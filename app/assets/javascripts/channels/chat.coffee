App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.info('Connected!!!')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.info('Disconnected!!!')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.info('Received data!!!')
    console.info(data)
    App.$rootScope.$broadcast('chat_notifications', data)

  new_message: ->
    console.info('New Message on Client!!!')
    @perform 'new_message'
