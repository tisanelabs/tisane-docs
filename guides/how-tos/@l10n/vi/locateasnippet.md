# Locating A Snippet Using Location Data

Tisane provides structured location data to help pinpoint flagged text fragments.

The three key location attributes are:

- `sentence_index` : Zero-based index of the sentence containing the snippet.     
- `offset`: Zero-based position of the first character in the snippet within the sentence.
- `length` : Number of characters in the snippet.                         

## How To Get The String

1. Find the sentence text containing the snippet:
   - Navigate to the `sentence_list` node.
   - Select a node where `index` = `sentence_index`.
   - Alternatively, retrieve the sentence directly from the sentence list array.
2. Get the substring:
   - Use the `offset` and `length` values to get the substring from the sentence.

## Why Relative Offsets Instead Of Absolute Positions?

We use sentence-based indexing instead of absolute offsets because many users need an actual sentence with the snippet for context.
