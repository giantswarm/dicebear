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
| image.tag | string | `""` | Image tag. Defaults to the chart's `appVersion` when left empty. |
| registry.domain | string | `"gsoci.azurecr.io"` | Registry domain the image is pulled from. |
| replicas | int | `2` | Number of DiceBear API replicas to run. |
| config.port | int | `3000` | Port the DiceBear API listens on. |
| config.pngSizeMax | int | `512` | Largest PNG size (px) the API will render. The avatar edge requests up to 512, and the upstream default of 256 is too small, so we raise the cap. |
| resources | object | `{"limits":{"cpu":"500m","memory":"256Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}` | Compute resources for the DiceBear API container. |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod-level security context. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container-level security context. |
