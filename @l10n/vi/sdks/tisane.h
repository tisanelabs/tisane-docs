#ifndef TISANE_H
#define TISANE_H

#ifndef WIN32 // or something like that...
#define __stdcall
#endif

extern "C" {
/**
 * Define the data path to the language models. MUST BE CALLED FIRST
 * @param dataRootPath the path to the language models root folder
 */
void __stdcall SetDbPath(const char *dataRootPath);

/***
 * Loads a language model associated with the specified language code. ONLY AFTER SetDbPath
 * @param languageCode the code of the language to load
 */
void __stdcall LoadAnalysisLanguageModel(const char *languageCode);

/***
 * Loads a language model associated with the specified language code for transformation (translation and paraphrase) applications. ONLY AFTER SetDbPath
 * @param languageCode the code of the target language to load
 */
void __stdcall LoadGenerationLanguageModel(const char *languageCode);

/***
 * Loads a customized language model associated with the specified language code. ONLY AFTER SetDbPath
 * @param languageCode the code of the language to load
 * @param customizationSuffix the suffix for the customization add-on model
 */
void __stdcall LoadCustomizedAnalysisLanguageModel(const char *languageCode, const char *customizationSuffix);

/***
 * Unloads a language model associated with the specified language code.
 * @param languageCode the code of the language to unload
 */
void __stdcall UnloadAnalysisLanguageModel(const char *languageCode);

/**
 * Links a callback function used when a language model is loaded.
 * @param ptrProgressCallback a void function with a double parameter; the parameter will be a number in range 0 thru 1 indicating the progress
 */
 void SetProgressCallback(void __stdcall ptrProgressCallback(double));


/**
 * Links a callback function used when content is parsed.
 * @param ptrParseProgressCallback a bool function with a double parameter; the parameter will be a number in range 0 thru 1 indicating the progress. The return value signals whether to abort processing (true).
 */
void SetParseProgressCallback(bool __stdcall ptrParseProgressCallback(double));

/**
 * Activates the lazy loading mode.
 */
void ActivateLazyLoading();

/**
 * Gets whether the lazy loading mode is active.
 * @return true if the lazy loading mode is active, false the lazy loading mode is not active.
 */
bool IsLazyLoadingActive();

/**
 * Parse the specified content in the specified language using the specified settings
 * @param language the language code
 * @param content the text to parse (UTF-8 encoding)
 * @param settings the settings according to the settings specs
 * @return a JSON structure according to the response specs
 */
 const char* __stdcall Parse(const char * language, const char * content, const char * settings);

                                            
/**
 * Translate or paraphrase a string from one language to another
 * @param sourceLanguage the source language code
 * @param targetLanguage the target language code
 * @param content the text to transform (UTF-8 encoding)
 * @param settings the settings according to the [settings specs](tisane_settings.md)
 * @return a translated or paraphrased string
 */
const char* __stdcall Transform(const char * sourceLanguage, const char * targetLanguage,
        const char * content, const char * settings);

}

#endif //TISANE_H
