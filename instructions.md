# Getting started with SimpleX weatherBot

## About

SimpleX Chat weatherBot as a service.

This is a weatherBot chat client that uses javascript WebSocket API client from [SimpleX Chat terminal CLI](https://github.com/simplex-chat/simplex-chat/blob/stable/docs/CLI.md) along with `node.js` to run the typescript package from `Simplex Chat SDK`


## weatherBot features

- weatherBot: a chat bot that provides localized weather information to SimpleX Chat users
- provider framework: supports adding additional, free or paid weather service providers to the weatherBot
- private: separation of user identifiable information, via SimpleX Chat, from weather service providers
- focused: weatherBot provides simplified, succinct information void of adverts and other distractions meant to monetize the user's attention

Enjoy having fun with weatherBot! 

For detailed description of weatherBot, check out the [gitHub weatherBot repo](https://github.com/start9labs/weatherbot).


In SimpleX, participants choose which servers to use for receiving messages and files. I receive through my private server, and you receive through your private server. Or we could both receive through the same private server. Or we could each use different public servers.

SimpleX servers function as queues. Servers only store messages until a client retrieves them, after which they are deleted. This means message histories are stored on client devices, so it is client devices that must be backed up to prevent loss of messages.

For detailed instructions on using SimpleX, check out the [official docs](https://simplex.chat/docs/guide/readme.html).



### Create a SimpleX address (optional)

You can now create a SimpleX Address if you want, but you should _not_ share the address publicly, as it will link the .onion URL to your identity. Remember, the purpose of this profile is total anonymity.
