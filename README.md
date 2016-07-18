# Action Cable Chat

Just a small app for testing out ActionCable

To run it yourself:

- `git clone https://github.com/alexsanford/action_cable_chat.git`
- `cd action_cable_chat`
- `bundle install`
- `rails db:migrate`
- rails server
- Point browser to http://localhost:3000

To look through the code, check out the following files:

### `app/channels/application_cable/connection.rb`

Every client (e.g. browser tab, device, etc) will open a WebSocket connection to the server. This is the place where you can customize some options. For example, you may wish to put an identifier on the connection so that you can find all connections belonging to a specific user.

### `app/channels/application_cable/channel.rb`

On each Connection to the server, there may be multiple Channels. A Channel is like a logical communication pathway between the client and the server. We will be creating a single channel in this app, but you may create as many as you want. This is the file that all Channel classes will inherit from, and so any global code or configuration for Channels goes here.

### `app/assets/javascripts/cable.coffee`

This is the top level file that configures ActionCable on the client side. Here, we create an `App` object and give it a `cable` attribute which holds the client-side cable object. We will use this later to form an actual connection.

Also, because this is an angular app, we want the `App` object to be able to broadcast events on `$rootScope` when data comes down from the server through a WebSocket. So we add an angular `.run` function to give `App` a reference to `$rootScope`. This actually isn't the best solution, as it means we can (and do) access `$rootScope` outside of an angular digest cycle. I'm not yet sure what the best solution is, but this isn't it. However, it works for now. We'll see this in action later.

### `app/channels/chat_channel.rb`

This is the server side of the Channel. This was generated using a `rails generate` command. It has two hooks: `subscribed` and `unsubscribed`. Currently the only functionality is the line `stream_from 'chat_notifications'`. We will see this in action later. Essentially, any code on the server may broadcast a message using the `'chat_notifications'` broadcast name. At that point, the ChatChannel will stream that message through the WebSocket and to the client.

It is worth noting that there is also a way to call methods on this class from our JavaScript code. It is very easy, and it could be very useful, but I didn't use it in this app.

### `app/controllers/messages_controller.rb`

Basically a normal Rails controller for POSTing a new chat message to the server. However, notice that in the `create` action, the method `notify_new_message` is called. Down below, `notify_new_message` is defined. This is where the server side does a broadcast to the `'chat_notifications'` broadcast channel, which ultimately goes down to the client side through a WebSocket. Yay!

Note that I send both a `type` attribute to indicate that this is a notification of a New Message on the server, and a `message` attribute with the actual message data.

### `app/assets/javascripts/channels/chat.coffee`

This file is also generated from the `rails generate` command mentioned above. It has a few hooks: `connected` for when the server has finalized the WebSocket connection, `disconnected` for when the server terminates the connection, and `received` for when the server sends data. You'll see that this is where we are broadcasting an event on `$rootScope` so that our angular controllers may be notified when new data comes down from the server. I called this event `'chat_notifications'`, which is the same as the server-side broadcast name. But there is no need to do so. It may be called something completely different.

### `app/assets/javascripts/home.coffee`

This is a typical angular controller, except that it listens to the `'chat_notifications`' angular broadcast using `$scope.$on`. This listener will be called when the `$broadcast` is called from `chat.coffee`, and it will update the UI.

## So there you have it!

Run the app, and send messages around. You will need to include a name when you send a message. Open it up in two browsers, and see your messages show up magically in both places. Enjoy!
