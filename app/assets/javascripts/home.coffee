angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http'
  ($scope, $http) ->
    $http.get('/messages.json').then (response) ->
      $scope.messages = response.data

    $scope.clearMessage = ->
      $scope.name = ''
      $scope.message = ''

    $scope.sendMessage = ->
      $http.post('/messages.json'
        sender: $scope.name
        message: $scope.message
        authenticity_token: $scope.authToken
      )
      $scope.clearMessage()

    $scope.clearMessage()
])
