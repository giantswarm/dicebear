# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Deployment, Service, and ServiceAccount for the self-hosted DiceBear HTTP API, pinned to the retagged `gsoci.azurecr.io/giantswarm/dicebear-api` image, with `PNG_SIZE_MAX=512`, a read-only root filesystem, TCP health probes, and pod anti-affinity across nodes.

[Unreleased]: https://github.com/giantswarm/dicebear/tree/main
