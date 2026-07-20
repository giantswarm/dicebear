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
| resources | object | `{"limits":{"cpu":"500m","ephemeral-storage":"256Mi","memory":"256Mi"},"requests":{"cpu":"50m","ephemeral-storage":"64Mi","memory":"64Mi"}}` | Compute resources for the DiceBear API container. |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod-level security context. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container-level security context. |
