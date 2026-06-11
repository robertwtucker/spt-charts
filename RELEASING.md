# Releasing

How to cut a release of a chart in this repo.

Currently in scope: **inspire**. Other charts will document their own release path here when their workflows come online.

## inspire

The CI workflow (`.github/workflows/ci.yml`) validates schema correctness on every PR. The release workflow (`.github/workflows/release.yml`) packages, pushes to GHCR, and signs with cosign on tag push. Both are necessary but not sufficient — they validate the chart artifact, not the deployed application. Tier 3 (real-image smoke against a real cluster) is a manual pre-tag step.

### 1. Tier 3 local smoke install

Before tagging, install the chart locally against a working K8s cluster with images from the official distribution repo pre-pulled (or credentials to a mirror) and confirm Inspire comes up healthy. This is the gate that catches anything Tier 1 (`ci.yml`) cannot — real image pulls, init-container ordering, JVM startup, probe behavior under real load.

Reference cluster: colima with `vz + vz-rosetta`. Expected wall-clock: ~4.5 min.

```bash
# Prereqs: colima up, registry pull-secret applied, postgresql + elastic up,
# license-server and admin-pass secrets present in target namespace.

helm upgrade --install inspire ./inspire \
  --namespace inspire \
  --create-namespace \
  --values <your-registry-pointing-values>.yaml \
  --wait --timeout 10m
```

Verify:

- All pods Ready (`kubectl -n inspire get pods`)
- ICM, Interactive, and Scaler liveness probes passing
- Interactive and Scaler UIs reachable
- No `CrashLoopBackOff` or `ImagePullBackOff` events in the last 5 minutes

If any of the above fails, **do not tag**. Open an issue / fix the chart / iterate values.

### 2. Bump Chart.yaml version

Reset the chart's `version:` field to the new refarch SemVer. The refarch tracks its own SemVer line — it is not tied to the upstream Quadient chart version. See the upstream attribution annotation (`com.quadient.spt.refarch.upstream-chart-version`) for the derivation pointer.

```yaml
# inspire/Chart.yaml
version: 1.0.1 # or whatever the next refarch version is
```

Commit on a release branch or directly on master per workflow preference. The release workflow verifies the tag version equals this field; mismatch fails the workflow before any push.

### 3. Tag and push

```bash
git tag inspire-v1.0.1
git push origin inspire-v1.0.1
```

The push triggers `.github/workflows/release.yml`. Expected steps:

1. `validate` job — re-runs `ci.yml` Tier 1 gates
2. Tag-vs-Chart.yaml version equality check
3. `helm package inspire`
4. GHCR login (uses `GITHUB_TOKEN`)
5. `helm push` to `oci://ghcr.io/<owner>/charts`
6. `cosign sign` with keyless OIDC (no long-lived signing keys)
7. `cosign verify` to confirm the signature is queryable

If any step fails, the GHCR artifact may be partially published. Re-running requires deleting the tag, deleting the GHCR artifact version (if present), and re-pushing the tag. Prefer to dry-run via PR first.

### 4. Post-release verification

```bash
# Confirm the artifact is pullable
helm pull oci://ghcr.io/<owner>/charts/inspire --version 1.0.1

# Confirm the signature
cosign verify ghcr.io/<owner>/charts/inspire:1.0.1 \
  --certificate-identity-regexp "^https://github.com/<owner>/spt-charts/" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com"

# Confirm annotations are present
helm show chart oci://ghcr.io/<owner>/charts/inspire --version 1.0.1 \
  | grep -A2 '^annotations:'
```

### 5. Rollback (if needed)

OCI artifacts in GHCR cannot be overwritten by re-pushing the same version. To replace a bad release:

1. Delete the tag locally and on origin: `git tag -d inspire-v1.0.1 && git push origin :inspire-v1.0.1`
2. Delete the package version from GHCR (Settings → Packages → `inspire` → version → Delete)
3. Fix the issue, bump the patch version (don't reuse the deleted version), re-tag
