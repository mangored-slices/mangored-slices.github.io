define 'model.account', ->
  class Account extends Backbone.Model

# -----
define 'collection.accounts', ->
  class Accounts extends Backbone.Collection
    model: require('model.account')
