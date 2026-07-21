# dicebear

Self-hosted DiceBear avatar HTTP API, used to render deterministic agent avatar icons.

**Homepage:** <https://github.com/giantswarm/dicebear>

## Source Code

* <https://github.com/giantswarm/dicebear>
* <https://github.com/dicebear/dicebear>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.name | string | `"giantswarm/dicebear-api"` | Repository of the DiceBear API image, relative to the registry domain. |
| image.tag | string | `"4.9"` | Image tag. Pinned explicitly to the mirrored upstream tag; do NOT leave empty to fall back to appVersion, because app-build-suite rewrites appVersion to the chart's dev/release version at build time. |
| registry.domain | string | `"gsoci.azurecr.io"` | Registry domain the image is pulled from. |
| replicas | int | `2` | Number of DiceBear API replicas to run. |
| config.port | int | `3000` | Port the DiceBear API listens on. |
| config.pngSizeMax | int | `512` | Largest PNG size (px) the API will render. The avatar edge requests up to 512, and the upstream default of 256 is too small, so we raise the cap. |
| emptyDirSizeLimit | string | `"64Mi"` | Size limit for the emptyDir volumes backing `/tmp` (PNG rendering) and `/run`, to bound node ephemeral-storage use. |
| resources | object | `{"limits":{"cpu":"500m","ephemeral-storage":"256Mi","memory":"256Mi"},"requests":{"cpu":"50m","ephemeral-storage":"64Mi","memory":"128Mi"}}` | Compute resources for the DiceBear API container. |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod-level security context. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container-level security context. |
| route.enabled | bool | `false` | Enable the HTTPRoute and Envoy Gateway HTTPRouteFilter resources. |
| route.parentRefs | list | `[]` | Parent Gateway references the HTTPRoute attaches to. Required when enabled. |
| route.hostnames | list | `[]` | Hostnames the avatar endpoint is served on (e.g. `avatars.example.com`). |
| route.version | string | `"v1"` | Path version segment. A future global restyle bumps this to mint fresh URLs. |
| route.sizes | list | `[48,96,128,512]` | Allowed avatar sizes (px). Only these are accepted in the URL. |
| route.defaultSize | int | `512` | Size used when the URL omits one. Must be one of `sizes`. |
| route.preview | bool | `true` | Also expose no-cache preview routes under `/<version>/preview/...` for the creation-time live preview. |
| route.annotations | object | `{}` | Extra annotations for the HTTPRoute. |
| route.labels | object | `{}` | Extra labels for the HTTPRoute. |
