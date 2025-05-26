# Lazy loading vs Fully Loaded Mode

Tisane language models contain extensive information about the language, and so may take hundreds of megabytes when fully loaded in RAM. 

When using Tisane occasionally or on a device with limited RAM, a better option is so-called lazy loading. In the lazy loading mode, linguistic data is loaded only when required, resulting in huge savings of RAM.

1. Lazy Loading (Recommended for incidental use)
   - Loads only essential parts of the language model during initialization. The full lexicon is accessed as needed.
   - Initialization: ~1 second
   - Initial Query Performance:  Much slower for the first few calls, then 10% to 30% slower.
   - Memory: ~20-40 MB per language + 40-60 MB base
2. Preloading (Recommended for servers/bulk data processing)
   - Loads the full language model into RAM at startup (except spellchecking dictionary).
   - Initialization:(20-40 seconds on a modern machine with an SSD.
   - Memory: ~400 MB - 2 Gb per language + 40-60 MB base. (More morphologically complex languages required more RAM.)

Important considerations:

*   You can preload some language models while leaving others in lazy-loading mode.
*   Once lazy loading is enabled, it cannot be disabled for the lifetime of the library or `Tisane.Server` instance.
*   Choose the loading strategy that best aligns with your application's performance requirements and resource constraints.

## Activating Lazy Loading

By default, all language models are loaded in full. To activate lazy loading mode, use `ActivateLazyLoading` method. (The .NET assembly calls it after the preloading.)

As soon as lazy loading mode is activated, all the subsequently loaded models are in lazy loading mode.