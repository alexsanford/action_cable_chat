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

### `app/channels/chat_channel.rb`

This is the server side of the Channel. This was generated using a `rails generate` command. It has two hooks: `subscribed` and `unsubscribed`. Currently the only functionality is the call to `stream_for`. We will see this in action later. Essentially, any code on the server may broadcast a message using a "broadcasting name". The broadcasting name may be a simple string, or it may be an array of objects as it is here. The array of objects, along with the channel name, will be converted into a string. In this case, the broadcasting name will be "chat:Message:new". When some code in the server broadcasts a messaging using this broadcasting name, this channel will receive that message and stream it down to the client over the WebSocket connection.

It is worth noting that there is also a way to call methods on this class from our JavaScript code. It is very easy, and it could be very useful, but I didn't use it in this app.

### `app/controllers/messages_controller.rb`

Basically a normal Rails controller for POSTing a new chat message to the server. However, notice that in the `create` action, the method `notify_new_message` is called. Down below, `notify_new_message` is defined. This is where the server side does a broadcast to the `[ Message, :new ]` broadcasting on `ChatChannel`, which ultimately goes down to the client side through a WebSocket. Yay!

### `app/assets/javascripts/home.coffee`

This is a typical angular controller, except that it uses the `angular-actioncable` library to listen for the broadcasted messages. To do so, simply open up a subscription to the channel, in this case, `"ChatChannel"`, and register a callback.

By default, rails will generate files for you: `app/assets/javascripts/cable.coffee` and `app/assets/channels/chat.coffee`. These files are not required if you're using `angular-actioncable` like I am. They can be safely deleted.

### Configuration

In order to use `angular-actioncable`, you need to do some configuration to tell angular which URL to connect to in order to instantiate the WebSocket connection. There are a few ways to do this. The way I chose to do it was to configure the ActionCable URL in the Rails configuration (see `config/environments/development.rb`) and then add a meta tag to the rails views (see `app/views/layouts/application.html.erb`). You can also configure `angular-actioncable` [directly](https://github.com/angular-actioncable/angular-actioncable#configuration-actioncableconfig).

## So there you have it!

Run the app, and send messages around. You will need to include a name when you send a message. Open it up in two browsers, and see your messages show up magically in both places. Enjoy!
