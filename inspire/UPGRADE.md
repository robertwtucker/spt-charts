## Supported application versions

Minimal application versions deployable by this Helm chart release:

| Product     | FMAP version |       GA version       |
|-------------|:------------:|:----------------------:|
| Scaler, SEN |  16.4 FMAP   |   15.0 SP2, 16.0 GA    |
| ICM, IPS    |  16.4 FMAP   |   15.0 SP4, 16.0 GA    |
| Interactive |  16.4 FMAP   | 15.0.667.0 HF, 16.0 GA |
| Automation  |  16.4 FMAP   |     16.0.607.0-HF      |

**IMPORTANT**: Deploying the R15 version of Inspire Flex using Google Kubernetes Engine (GKE) is not supported.

## Upgrading

### To 2.0.0

- The default Scaler user automatically receives the ICM right 'Package import + override rights on export'
- We have changed the default values of the following properties to increase the security of the solution:
  - Breaking Change: `icm.securityContext.readOnlyRootFilesystem` was set to True
  - We have added a default value for the Seccomp profile type of Pod security context. It is now set to `RuntimeDefault` and it is configurable via
    `icm.podSecurityContext.seccompProfile.type`, `scaler.podSecurityContext.seccompProfile.type` and `interactive.podSecurityContext.seccompProfile.type`
- The API version of Scaler's HorizontalPodAutoscaler has been changed from `autoscaling/v2beta2` to `autoscaling/v2` to be compatible with the latest Kubernetes versions.
  This means that the earliest version of Kubernetes supported by this resource is 1.23.
- The values of additional deployment annotations settable via `icm.deployment.annotations` and `interactive.deployment.annotations` are now automatically
  quoted (unified behavior with `scaler.deployment.annotations`). Therefore, it is not necessary to use escaped double quotes when passing non-string-like values.
- We have removed the property `global.dataRecording.prepareConfigurationVariables` which was required for the correct Data Recording configuration in older Scaler versions.
  This configuration property was necessary when using Data Recording along with Scaler version 15.0 earlier than SP2 or FMAP version earlier than 15.4.