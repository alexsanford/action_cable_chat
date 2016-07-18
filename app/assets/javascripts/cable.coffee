# Action Cable provides the framework to deal with WebSockets in Rails.
# You can generate new channels where WebSocket features live using the rails generate channel command.
#
#= require action_cable
#= require_self
#= require_tree ./channels

window.App || (window.App = {})
App.cable = ActionCable.createConsumer()

# Give application cable access to $rootScope
angular.module('ActionCableChat').run([
  '$rootScope'
  ($rootScope) ->
    App.$rootScope = $rootScope
])
