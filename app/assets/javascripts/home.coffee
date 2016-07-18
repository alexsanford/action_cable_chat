angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http'
  ($scope, $http) ->
    $http.get('/messages.json').then (response) ->
      $scope.messages = response.data

    $scope.clearMessage = ->
      $scope.message = ''

    $scope.sendMessage = ->
      $http.post('/messages.json'
        message:
          sender: $scope.name
          message: $scope.message
      )
      $scope.clearMessage()

    $scope.name = ''
    $scope.clearMessage()
])
