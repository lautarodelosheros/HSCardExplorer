# HSCardExplorer

This is a simple gallery app implemented with SwiftUI that allows to search and filter for Hearthstone cards retrieved from the official Battle.net API.

This project has HearthstoneAPIKey unimplemented on purpose to not expose the Battle.net API Key. In order to compile it implement the class locally as follows:

```swift
class HearthstoneAPIKey {
    static let secret = "clientId:clientSecret"
    static let accessToken = "accessToken" // Can be left empty
}
```

Where the client ID and secret can be obtained from https://develop.battle.net/access/clients

AccessToken is only defined for preview convinience and it's not required to run the app.
