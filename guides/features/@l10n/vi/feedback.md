# Can I Send a Feedback to Improve the Results?

Yes.

The method is `POST /feedback.` (Note: it’s a method in the LaMP web service, not Tisane.)

Simply forward the original Tisane API request, specifying your API key or your custom code in the Authorization header.

For example:

Body

```json
{"language":"en", "content":"it's alive", "settings":{}}
```

The method returns a JSON response with the following attributes:

success (boolean): whether the feedback submission was successful
error (string, optional): if an error occurred, what the error is
The response is purely for debugging purposes. You can send the request asynchronously, and ignore the response.