angular.module('ActionCableChat').controller('ChatWindowCtrl', [
  '$scope', '$http'
  ($scope, $http) ->
    $http.get('/messages.json').then (response) ->
      $scope.messages = response.data
])
