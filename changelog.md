# Changelog

Notable changes to Tisane codebase will be documented in this file.

## [4.9.0.0] - 2025-25-17

### Added

* Chunked processing using new methods `ParseTextFile` and `ParseStream` (C++ SDK only)
* To support chunking and merging results, possibility to set the initial `offset` and `sentence_index`, which are then taken into consideration.

### Changed

* Improvements to the throughput with large inputs

## [4.8.0.0] - 2025-04-17

### Added

* Parse progress callback with an easy way to abort long processing
* First take on relations between entities. Currently disabled by default, `relations` setting must be set to `true`

### Changed

* Long-term memory is no longer output by default. To reactivate, `state` setting must be set to `true`

### Fixed

* Certain duplicate entity issues
* Coreference resolution issues