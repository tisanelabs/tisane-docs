# Analyzing, Validating, and Comparing Names

## Parsing Full Names

Tisane can break down full names into key components:

| Attribute     | Description                         |
| ------------- | ----------------------------------- |
| `given_name`  | First name (e.g., *John*)           |
| `middle_name` | Middle name (if applicable)         |
| `surname`     | Last name (e.g., *Doe*)             |
| `title`       | Honorifics (e.g., *Dr., Mr., Ms.*)  |
| `suffix`      | Name suffix (e.g., *Jr., Sr., III*) |
| `social_role` | Roles like *Haji* or *Dr.*          |

## How To Parse A Name

To parse a full name, send a `POST /parse` request with:

* `"entity": "person"`
* `"words": true`


The response will categorize the name components under the `role` attribute.

Example of Name Parsing:
![tisaneAliKilicoglu.png](../../images/tisaneAliKilicoglu.png)


## Validating Real Names

While Tisane cannot verify if a user’s provided name is real, it recognizes many names associated with:

- Famous figures (`important_person`)
- Fictional characters (`fictional_character`)
- Spiritual beings (`spiritual_being`)
- Names that don’t appear to be names (for example: User-13789026152908425434)

For a list of common fake names, refer to [this Quora post](https://qr.ae/pNKxWl).


The `subtype` attribute in the `entity` structure indicates the type of name detected, with a Wikidata ID if available.

Example of Fictional Character Name Parsing:

![tisaneFictionalCharacter.png](../../images/tisaneFictionalCharacter.png)



## Comparing Names

The `/compare/entities` method allows comparing two names (even across languages) and detecting differences.

### Example Comparisons

| Name 1           | Name 2                              | Result                                                 |
| ---------------- | ----------------------------------- | ------------------------------------------------------ |
| *William Smith*  | *Will Smith*                        | `{"result":"different","differences":["variation"]}`   |
| *Musa Bin Osman* | *Haji Musa Bin Osman*               | `{"result":"different","differences":["social_role"]}` |
| *William Smith*  | *Вилл Смит* (Will Smith in Russian) | `{"result":"different","differences":["variation"]}`   |
| *Kevin Tan*      | *TAN Kevin*                         | `{"result":"same"}`                                    |

### **How To Compare Names**

Send a request to the `/compare/entities` endpoint with the names to compare, and the response will return differences in attributes like:

- `variation` (e.g., *William* vs *Will*)
- `social_role` (e.g., *Haji Musa* vs *Musa*)
- `case_difference` (e.g., *John Doe* vs *JOHN DOE*)
- `same` (Identical names, even if the order differs)


## Vetting Nicknames and Aliases

Usernames and aliases can be misleading, offensive, or abusive. Tisane detects inappropriate usernames (e.g., *Hitler*, *UserJohn_is_liar*).

### How To Vet A Nickname

Send a send a `POST /parse` request with:

- ` "format": "alias"`

- The `subscope` setting ensures names are properly segmented, even if written in camel case, with underscores, or without spaces.

Example of nickname vetting:

![tisaneAliasCreep.png](../../images/tisaneAliasCreep.png)
