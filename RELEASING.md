# Releasing

How to cut a release of a chart in this repo.

Currently in scope: **inspire**, **adapt**, and **docuhost**. Other charts will document their own release path here when their workflows come online.

## inspire

The CI workflow (`.github/workflows/ci-inspire.yml`) validates schema correctness on every PR. The release workflow (`.github/workflows/release-inspire.yml`) packages, pushes to GHCR, and signs with cosign on tag push. Both are necessary but not sufficient — they validate the chart artifact, not the deployed application. Tier 3 (real-image smoke against a real cluster) is a manual pre-tag step.

### 1. Tier 3 local smoke install

Before tagging, install the chart locally against a working K8s cluster with images from the official distribution repo pre-pulled (or credentials to a mirror) and confirm Inspire comes up healthy. This is the gate that catches anything Tier 1 (`ci-inspire.yml`) cannot — real image pulls, init-container ordering, JVM startup, probe behavior under real load.

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

The push triggers `.github/workflows/release-inspire.yml`. Expected steps:

1. `validate` job — re-runs `ci-inspire.yml` Tier 1 gates
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

## adapt

The CI workflow (`.github/workflows/ci-adapt.yml`) validates schema correctness on every PR. The release workflow (`.github/workflows/release-adapt.yml`) packages, pushes to GHCR, and signs with cosign on tag push. As with inspire, these validate the chart artifact, not the deployed application — Tier 3 (real-image smoke against a real cluster) is a manual pre-tag step.

Two things make adapt's release differ from inspire's:

- **OCI subchart dependency.** adapt depends on `inspire` pulled from `oci://ghcr.io/robertwtucker/charts`. `*.tgz` is gitignored, so only `adapt/Chart.lock` is committed — both CI and release run `helm dependency build adapt` to reconstruct `adapt/charts/` from the locked digest. The published adapt chart bundles its locked inspire subchart.
- **Post-renderer ships separately.** The Helm 4 post-renderer plugin (`adapt-scaler-inject`) lives at `adapt/post-renderer/` but is excluded from the package by `adapt/.helmignore`. It is NOT in the published OCI artifact; consumers install it once per machine via `helm plugin install`. Because it requires `--post-renderer` resolution by plugin name, **adapt requires Helm 4** (the workflows pin `v4.2.1`).

### 1. Tier 3 local smoke install

Before tagging, install the chart locally against a working K8s cluster and confirm the License Server serves licenses and (on the integrated path) the Scaler can exec UA end-to-end. This is the gate that catches what Tier 1 (`ci-adapt.yml`) cannot — real binary-license validation, init-container ordering, and the post-renderer's Scaler injection running against live images.

```bash
# Prereqs: cluster up, registry pull-secret + spt-secrets/postgresql secrets
# present in the target namespace, inspire dependencies (db, etc.) available.

# Reconstruct the inspire subchart (matches what CI/release do).
helm dependency build ./adapt

# Install the post-renderer plugin once per machine.
helm plugin install ./adapt/post-renderer

# Real Adapt licenses are binary — pass them with --set-file, not --set.
helm upgrade --install adapt ./adapt \
  --namespace adapt \
  --create-namespace \
  --set-file licenseServer.license=./LicSer.lic \
  --set-file ua.license=./adeptua.lic \
  --values <your-registry-pointing-values>.yaml \
  --post-renderer adapt-scaler-inject \
  --wait --timeout 10m
```

Verify:

- License Server pod Ready; `cdplicser` serving on its Service (LS clients can check out a license)
- On the integrated path: Inspire Scaler pod Ready, `deploy-ua` initContainer completed, and Scaler can exec UA binaries from `/opt/adapt/ua`
- No `CrashLoopBackOff` or `ImagePullBackOff` events in the last 5 minutes

If any of the above fails, **do not tag**. Open an issue / fix the chart / iterate values.

### 2. Bump Chart.yaml version

Reset the chart's `version:` field to the new refarch SemVer. The refarch tracks its own SemVer line, decoupled from the upstream Adapt component versions (see the `com.quadient.spt.refarch.adapt-*-version` annotations for the derivation pointers).

```yaml
# adapt/Chart.yaml
version: 1.0.1 # or whatever the next refarch version is
```

The release workflow verifies the tag version equals this field; mismatch fails the workflow before any push.

### 3. Tag and push

```bash
git tag adapt-v1.0.1
git push origin adapt-v1.0.1
```

The push triggers `.github/workflows/release-adapt.yml`. Expected steps:

1. `validate` job — re-runs `ci-adapt.yml` Tier 1 gates
2. Tag-vs-Chart.yaml version equality check
3. `helm dependency build adapt` (so the package bundles inspire)
4. `helm package adapt`
5. GHCR login (uses `GITHUB_TOKEN`)
6. `helm push` to `oci://ghcr.io/<owner>/charts`
7. `cosign sign` with keyless OIDC (no long-lived signing keys)
8. `cosign verify` to confirm the signature is queryable

If any step fails, the GHCR artifact may be partially published. Re-running requires deleting the tag, deleting the GHCR artifact version (if present), and re-pushing the tag. Prefer to dry-run via PR first.

### 4. Post-release verification

```bash
# Confirm the artifact is pullable
helm pull oci://ghcr.io/<owner>/charts/adapt --version 1.0.1

# Confirm the signature
cosign verify ghcr.io/<owner>/charts/adapt:1.0.1 \
  --certificate-identity-regexp "^https://github.com/<owner>/spt-charts/" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com"

# Confirm annotations are present
helm show chart oci://ghcr.io/<owner>/charts/adapt --version 1.0.1 \
  | grep -A2 '^annotations:'
```

### 5. Rollback (if needed)

OCI artifacts in GHCR cannot be overwritten by re-pushing the same version. To replace a bad release:

1. Delete the tag locally and on origin: `git tag -d adapt-v1.0.1 && git push origin :adapt-v1.0.1`
2. Delete the package version from GHCR (Settings → Packages → `adapt` → version → Delete)
3. Fix the issue, bump the patch version (don't reuse the deleted version), re-tag

## docuhost

The CI workflow (`.github/workflows/ci-docuhost.yml`) validates schema correctness on every PR. The release workflow (`.github/workflows/release-docuhost.yml`) packages, pushes to GHCR, and signs with cosign on tag push. As with the other charts, these validate the chart artifact, not the deployed application — Tier 3 (real end-to-end against a real cluster) is a manual pre-tag step.

docuhost is the simplest of the three to release: no subchart dependencies, no post-renderer, and it pins Helm `v3.16.3` like inspire. The chart bytes are all that's published — the docuhost app image is released separately.

The one thing Tier 1 cannot exercise is the **MongoDB init script** that provisions the application user. It only fires against a live mongo container, which `helm install --dry-run=server` does not start — so a real install is the only gate that proves docuhost can actually authenticate to its database.

### 1. Tier 3 local smoke install

Before tagging, install the chart against a working K8s cluster and confirm docuhost connects to MongoDB. The chart ships an embedded MongoDB (`mongodb.enabled=true`, the default), so no external database is required for the smoke.

```bash
# Prereqs: cluster up; registry pull-secret applied only if the docuhost
# image is private. Embedded MongoDB needs no external DB.

helm upgrade --install docuhost ./docuhost \
  --namespace docuhost \
  --create-namespace \
  --set auth.secret="$(openssl rand -base64 32)" \
  --set db.password=<choose-a-password> \
  --set mongodb.auth.rootPassword=<choose-a-password> \
  --wait --timeout 10m
```

Verify:

- docuhost and mongodb pods Ready (`kubectl -n docuhost get pods`)
- The mongo init script provisioned the `docuhost` application user (no auth errors in the docuhost pod logs on startup)
- docuhost's HTTP endpoint is reachable
- No `CrashLoopBackOff` or `ImagePullBackOff` events in the last 5 minutes

If any of the above fails, **do not tag**. Open an issue / fix the chart / iterate values.

### 2. Bump Chart.yaml version

Reset the chart's `version:` field to the new release SemVer.

```yaml
# docuhost/Chart.yaml
version: 0.4.1 # or whatever the next version is
```

The release workflow verifies the tag version equals this field; mismatch fails the workflow before any push.

### 3. Tag and push

```bash
git tag docuhost-v0.4.1
git push origin docuhost-v0.4.1
```

The push triggers `.github/workflows/release-docuhost.yml`. Expected steps:

1. `validate` job — re-runs `ci-docuhost.yml` Tier 1 gates
2. Tag-vs-Chart.yaml version equality check
3. `helm package docuhost`
4. GHCR login (uses `GITHUB_TOKEN`)
5. `helm push` to `oci://ghcr.io/<owner>/charts`
6. `cosign sign` with keyless OIDC (no long-lived signing keys)
7. `cosign verify` to confirm the signature is queryable

If any step fails, the GHCR artifact may be partially published. Re-running requires deleting the tag, deleting the GHCR artifact version (if present), and re-pushing the tag. Prefer to dry-run via PR first.

### 4. Post-release verification

```bash
# Confirm the artifact is pullable
helm pull oci://ghcr.io/<owner>/charts/docuhost --version 0.4.1

# Confirm the signature
cosign verify ghcr.io/<owner>/charts/docuhost:0.4.1 \
  --certificate-identity-regexp "^https://github.com/<owner>/spt-charts/" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com"

# Confirm annotations are present
helm show chart oci://ghcr.io/<owner>/charts/docuhost --version 0.4.1 \
  | grep -A2 '^annotations:'
```

### 5. Rollback (if needed)

OCI artifacts in GHCR cannot be overwritten by re-pushing the same version. To replace a bad release:

1. Delete the tag locally and on origin: `git tag -d docuhost-v0.4.1 && git push origin :docuhost-v0.4.1`
2. Delete the package version from GHCR (Settings → Packages → `docuhost` → version → Delete)
3. Fix the issue, bump the patch version (don't reuse the deleted version), re-tag
