angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http', '$timeout', 'ActionCableChannel'
  ($scope, $http, $timeout, ActionCableChannel) ->
    # Get latest message list from server
    $scope.refreshMessages = ->
      $http.get('/messages.json').then (response) ->
        $scope.messages = response.data
        $scope.scrollToBottom()

    # Clear new message form
    $scope.clearMessage = ->
      $scope.message = ''

    # Create new message on server
    $scope.sendMessage = ->
      $http.post('/messages.json'
        message:
          sender: $scope.name
          message: $scope.message
      )
      $scope.clearMessage()

    # Init page
    $scope.name = ''
    $scope.clearMessage()
    $scope.refreshMessages()

    # Subscribe to chat notifications
    channel = new ActionCableChannel('ChatChannel')
    channel.subscribe(
      (message) ->
        $scope.messages.push(message)
        $scope.scrollToBottom()
    ).then ->
      console.info('Successfully Subscribed!! :D')

    # Scroll chat message window to the bottom
    # NOTE: bad practice to have this in a controller
    $scope.scrollToBottom = ->
      $timeout ->
        el = angular.element('#chat-window')[0]
        el.scrollTop = el.scrollHeight
])
