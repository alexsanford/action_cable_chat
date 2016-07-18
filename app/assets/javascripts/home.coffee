angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http', '$timeout'
  ($scope, $http, $timeout) ->
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

    # Listen for chat notifications
    $scope.$on 'chat_notifications', (event, data) ->
      if data.type == 'new_message'
        $scope.refreshMessages()

    # Scroll chat message window to the bottom
    # NOTE: bad practice to have this in a controller
    $scope.scrollToBottom = ->
      $timeout ->
        el = angular.element('#chat-window')[0]
        el.scrollTop = el.scrollHeight
])
