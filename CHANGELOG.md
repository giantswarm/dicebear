# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Deployment, Service, and ServiceAccount for the self-hosted DiceBear HTTP API, pinned to the retagged `gsoci.azurecr.io/giantswarm/dicebear-api` image, with `PNG_SIZE_MAX=512`, a read-only root filesystem, HTTP health probes against the initials render endpoint, pod anti-affinity across nodes, bounded `emptyDir` volumes with `ephemeral-storage` requests/limits, and a `PodDisruptionBudget` (`minAvailable: 1`, only when running more than one replica).
- App-test-suite smoke and functional tests (`tests/ats`) that deploy the chart on kind and assert the deployment runs and the initials avatar endpoint returns `200`. Upgrade tests are skipped until a first release exists.
- Optional public avatar routing (`route.enabled`, default off): a Gateway API `HTTPRoute` plus Envoy Gateway `HTTPRouteFilter` resources that expose the canonical `/<version>/<name>.png` (and `/<version>/<size>/<name>.png`) URL and rewrite it to the DiceBear query (`/10.x/initials/png?seed=…&size=…`). Only allowed sizes route, enforced by anchored regex matches; a no-store preview route is exposed under `/<version>/preview/...`. Requires Envoy Gateway on the target cluster; the operator supplies `parentRefs` and `hostnames`.

### Changed

- Raise the container memory request from `64Mi` to `128Mi`. The observed steady-state working set is ~100Mi (peaking ~140Mi), so the old request under-represented the pod to the scheduler; the request now sits above baseline with 2x burst room up to the unchanged `256Mi` limit.
- Constrain `route.version` to `^[a-zA-Z0-9]+$` (values schema plus a template guard). The value is interpolated unescaped into the path-matching regular expressions, so a metacharacter (e.g. the dot in `v1.2`) would silently widen or break routing rather than mint a distinct URL space.

[Unreleased]: https://github.com/giantswarm/dicebear/tree/main
