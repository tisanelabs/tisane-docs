# Troubleshooting
If your requests to Tisane API fail, check the error codes and troubleshooting steps below.

## API calls fail with error code 400 (Bad Request)

Usually this means malformed or invalid request body. In `/parse` and `/transform`, the input content and valid language codes must be specified.

Possible reasons:

- Invalid JSON. Check for unterminated string literals or unescaped double quotes in your strings.
- Invalid language code(s). Verify that the language model exists and the attribute name is correct (`language` in `/parse`, `from` and `to` in `/transform`).
- Missing `content` element.

## API calls fail with error code 401 (Unauthorized)

This means your request failed authorization. Possible reasons:

- Incorrect API Key
  - Ensure you provide the `Ocp-Apim-Subscription-Key` HTTP header with the correct API key value.

- Rate Limit Exceeded
  - Each subscription plan has a rate limit. The rate limit of the free Community Plan is set to 10 requests per minute only (enough to test, not enough to go to production for most purposes). Check the limits on the [Subscription Plans page](https://tisane.ai/subscription-plans/).

- Monthly Quota Exceeded
  - If you've reached the monthly quota, consider upgrading on the [Subscription Plans page](https://tisane.ai/subscription-plans/). Multiple notifications are sent when approaching the monthly quota.

## API calls fail with error code 404

Check that the method name is correct and that the verb is correct. For example, specifying `GET` when the operation uses `POST` will result in status code 404.

##  Other Error Codes (Invalid JSON Or Markup Issues)

If you're getting an error other than 401, check for invalid JSON formatting:

- Escaping Double Quotes Properly
  - If your content contains double quotes (`"`), ensure they are properly escaped (`\"`).

- Avoid Sending Markup Content
  - Tisane API processes natural language, so sending HTML, XML, or JSON as content may cause issues.
  - If you must send markup, sanitize your input before submitting.

##  Finding Your API Key

**tl;dr**: Sign in to our developer portal and retrieve your API key from your profile page.

### Step-by-Step Instructions

1. Log in using your credentials [here](https://dev.tisane.ai/signin/).
2. If you do not have an account, sign up [here](https://dev.tisane.ai/signup/).
3. Click the menu in the upper-right corner and go to *Profile*, or use [this direct link](https://dev.tisane.ai/profile).
4. Under *Primary Key* or *Secondary Key*, click *Show* to reveal your API key.
5. In your application, provide this key as `Ocp-Apim-Subscription-Key` HTTP header.

##  General Troubleshooting Steps

- Check your API key 
- Check your subscription limits
- Validate JSON formatting before sending
- Sanitize the input to remove any markup

## We Are Not Getting The Response We Were Expecting

While we cannot guarantee 100% accuracy, please [send us a note](https://tisane.ai/contact-us/#support) and we will look into it. We are constantly working on improving the accuracy of Tisane, and your collaboration is appreciated.

## Can I process text from a markup content (HTML or XML)?

Here is a generic regular expression that can be used in any programming language to remove HTML tags from text:

`<[^>]+>`

- `<` → Matches the **opening angle bracket** of an HTML tag.
- `[^>]+` → Matches **any characters inside the tag**, except `>`.
- `>` → Matches the **closing angle bracket** of an HTML tag.
