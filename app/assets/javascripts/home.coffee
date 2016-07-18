angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http', '$timeout'
  ($scope, $http, $timeout) ->
    $scope.refreshMessages = ->
      $http.get('/messages.json').then (response) ->
        $scope.messages = response.data
        $scope.scrollToBottom()

    $scope.refreshMessages()

    $scope.clearMessage = ->
      $scope.message = ''

    $scope.sendMessage = ->
      $http.post('/messages.json'
        message:
          sender: $scope.name
          message: $scope.message
      )
      $scope.clearMessage()
      App.chat.new_message()

    $scope.name = ''
    $scope.clearMessage()

    $scope.$on 'chat_notifications', (event, data) ->
      if data.type == 'new_message'
        $scope.refreshMessages()

    $scope.scrollToBottom = ->
      $timeout ->
        el = angular.element('#chat-window')[0]
        el.scrollTop = el.scrollHeight
])
