## Supported Application Versions

This Helm chart package supports the deployment of the latest release (the value of `appVersion` field in Chart.yaml) and actively supported
GA releases of the following Inspire Flex components:

|  Component  | GA Versions |
|:-----------:|:-----------:|
| Scaler, SEN |  R16, R17   |
|  ICM, IPS   |  R16, R17   |
| Interactive |  R16, R17   |
| Automation  |  R16, R17   |

To avoid compatibility issues, it is recommended to always use the latest available Hotfix or Service Pack version of each release.

## Upgrading

### To 4.0.0

- In response to the retirement of the Ingress NGINX project, we added support for the HAProxy Kubernetes Ingress Controller.
  The default for `global.ingress.type` is now an empty string (previously `nginx`).
  Before enabling an Ingress on the product level, set `global.ingress.type` explicitly to one of: `appgw`, `haproxy`, or `nginx`.

### To 3.0.0

- This Helm chart package now supports both Kubernetes and OpenShift. For detailed information on supported versions and cloud providers,
  refer to the 'Supported Platforms for Inspire Flex' document.
- A new variable, `global.ingress.type`, has been introduced. The default value is `nginx`, which is compatible with most cloud providers.
  For Azure Kubernetes Service, set the value to `appgw` before performing the upgrade to ensure proper functionality.

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