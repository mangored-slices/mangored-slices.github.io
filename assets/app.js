// Generated by CoffeeScript 1.6.3
define('app.config', function() {
  var Config, isLocal;
  isLocal = location.hostname.match(/localhost/);
  return Config = {
    feedUrl: isLocal ? 'sample' : 'http://slices-feeds.herokuapp.com'
  };
});
// Generated by CoffeeScript 1.6.3
define('app.fetcher', function() {
  var Fetcher;
  return Fetcher = (function() {
    function Fetcher() {
      this.url = App.config.feedUrl;
      this.entries = Data.entries;
    }

    /**
    * Starts fetching.
    * Returns a Promise object.
    */


    Fetcher.prototype.fetch = function() {
      return $.get("" + this.url + "/feed.json").then(function(data) {
        console.log(data);
        Data.accounts.reset(data.sources);
        return Data.entries.reset(data.entries);
      }).then(function() {
        return console.log("[Fetcher] ok");
      });
    };

    return Fetcher;

  })();
});
// Generated by CoffeeScript 1.6.3
define('app.loader', function() {
  /**
  Provides an interface to show and hide the loader.
  */

  var Loader;
  return Loader = (function() {
    function Loader() {
      NProgress.configure({
        speed: 80
      });
    }

    /**
    Loader.
    
    Starts a loader, and ends it when the given `promise` is
    resolved.
    */


    Loader.prototype.load = function(promise) {
      var _this = this;
      NProgress.start();
      return promise.always(function() {
        return NProgress.done();
      });
    };

    Loader.prototype.ping = function() {
      return NProgress.done(true);
    };

    return Loader;

  })();
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('model.account', function() {
  var Account, _ref;
  return Account = (function(_super) {
    __extends(Account, _super);

    function Account() {
      _ref = Account.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return Account;

  })(Backbone.Model);
});

define('collection.accounts', function() {
  var Accounts, _ref;
  return Accounts = (function(_super) {
    __extends(Accounts, _super);

    function Accounts() {
      _ref = Accounts.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Accounts.prototype.model = require('model.account');

    return Accounts;

  })(Backbone.Collection);
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('model.entry', function() {
  /**
  An entry.
  
  Fields:
  
   * `date`  -- (string) date
   * `image` -- (string) URL
   * `image_large` -- (string) URL
   * `image_ratio` -- (number) width-over-height ratio
   * `text` -- (string) Title
   * `fulltext` -- (string) Full text
   * `url` -- (href) permalink URL
   * `source` -- (object) source name
  */

  var Entry, _ref;
  return Entry = (function(_super) {
    __extends(Entry, _super);

    function Entry() {
      _ref = Entry.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    /**
      entry.dateAgo()   #=> "a few seconds ago"
    */


    Entry.prototype.dateAgo = function() {
      return moment(this.get('date')).fromNow();
    };

    /**
      entry.typeClass()   #=> "text" / "image"
    */


    Entry.prototype.typeClass = function() {
      var _ref1;
      if (((_ref1 = this.get('image')) != null ? _ref1.length : void 0) > 0) {
        return 'image';
      } else {
        return 'text';
      }
    };

    return Entry;

  })(Backbone.Model);
});

define('collection.entries', function() {
  var Entries, _ref;
  return Entries = (function(_super) {
    __extends(Entries, _super);

    function Entries() {
      _ref = Entries.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Entries.prototype.model = require('model.entry');

    return Entries;

  })(Backbone.Collection);
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('router.app', function() {
  var AppRouter, _ref;
  return AppRouter = (function(_super) {
    __extends(AppRouter, _super);

    function AppRouter() {
      _ref = AppRouter.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppRouter.prototype.routes = {
      '': 'home'
    };

    AppRouter.prototype.home = function() {
      return console.log("[AppRouter] home");
    };

    return AppRouter;

  })(Backbone.Router);
});
// Generated by CoffeeScript 1.6.3
$(function() {
  var App, Data;
  Data = window.Data = {};
  Data.entries = new (require('collection.entries'));
  Data.accounts = new (require('collection.accounts'));
  App = window.App = {};
  App.config = require('app.config');
  App.loader = new (require('app.loader'));
  App.router = new (require('router.app'));
  return App.fetcher = new (require('app.fetcher'));
});

$(function() {
  App.listView = new (require('view.list'));
  return App.loader.load(App.fetcher.fetch().done(function() {
    return Backbone.history.start();
  }));
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('view.entry', function() {
  var EntryView, r, _ref;
  r = function(role) {
    return "[role~='" + role + "']";
  };
  return EntryView = (function(_super) {
    __extends(EntryView, _super);

    function EntryView() {
      _ref = EntryView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    EntryView.prototype.render = function() {
      var entry, klass;
      entry = this.options.entry;
      this.$el.html(this.template);
      klass = entry.typeClass();
      this.renderCommon(entry, klass);
      if (klass === 'image') {
        this.renderImage(entry);
      }
      return this;
    };

    EntryView.prototype.renderCommon = function(entry, klass) {
      this.$el.addClass("entry-" + klass);
      this.$(r('text')).html(entry.get('text'));
      return this.$(r('date_ago')).html(entry.dateAgo());
    };

    EntryView.prototype.renderImage = function(entry) {
      return this.$(r('image')).append($("<img>").attr({
        src: entry.get('image')
      }));
    };

    EntryView.prototype.template = "<div class='image' role='image'>\n</div>\n<div class='text' role='text'></div>\n<div class='date' role='date_ago'></div>";

    return EntryView;

  })(Backbone.View);
});
// Generated by CoffeeScript 1.6.3
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('view.list', function() {
  var EntryView, ListView, _ref;
  EntryView = require('view.entry');
  return ListView = (function(_super) {
    __extends(ListView, _super);

    function ListView() {
      this.add = __bind(this.add, this);
      this.reset = __bind(this.reset, this);
      _ref = ListView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ListView.prototype.el = $('.list-view');

    /**
    Constructor
    */


    ListView.prototype.initialize = function() {
      this.entries = Data.entries;
      return this.listenTo(this.entries, {
        'reset': this.reset,
        'add': this.add
      });
    };

    /**
    Removes all entries.
    */


    ListView.prototype.reset = function(entries) {
      var _this = this;
      this.$el.html("");
      return entries.each(function(entry) {
        return _this.add(entry);
      });
    };

    /**
    Adds an entry.
    */


    ListView.prototype.add = function(entry) {
      var view;
      view = new EntryView({
        entry: entry
      });
      return this.$el.append(view.render().el);
    };

    return ListView;

  })(Backbone.View);
});
