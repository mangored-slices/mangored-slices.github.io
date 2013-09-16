define 'model.account', ->
  class Account extends Backbone.Model

# -----
define 'model.entries', ->
  class Accounts extends Backbone.Collection
    model: require('model.account')
