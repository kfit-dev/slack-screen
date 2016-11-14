# Channels

To start your Phoenix Channels app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:3666`](http://localhost:3666) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Purpose
This is meant to be a general framework to control Browser tabs using the Slack Chat Interface. The project uses Phoenix Channels which provides a convinient high level abstraction over web sockets.

###Use cases
- Control your tech startup's big screen monitors using the companies slack boards!
- More to come!

###Testing /screen endpoint
Once the index page is up on Localhost:3666, you can press the on button to connect through web sockets to Phoenix Channels. Now the app is connected with the Javascript client to control browser tabs. Test is out with $ curl command:

```

curl -H "Content-Type: application/json" -X POST -d '{"token":"gIkuvaNzQIHg97ATvDxqgjtO", "team_id":"T0001", "team_domain":"example", "channel_id": "C2147483705", "channel_name": "screen-kontrol", "user_id":"U2147483697", "user_name": "adrienshen", "command": "/screen", "text": "kfit", "response_url": "https://hooks.slack.com/commands/1234/5678"}' 127.0.0.1:3666/api/screens


```

The **text** you can fill in with `kfit | fave | ka | url(google.com)` url can be any url inside the parentesis. The way slack works is by issuing the same command such as the above to the endpoint specify.