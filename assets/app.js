// Generated by CoffeeScript 1.6.3
define('app.config', function() {
  var Config, isLocal;
  isLocal = location.hostname.match(/localhost/);
  return Config = {
    feedUrl: isLocal ? 'sample' : $("[rel='feedscout_url']").attr('href')
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
define('lib.onfirstvisit', function() {
  /**
  * Runs something on the first visit.
  *
  *     onFirstVisit
  *       days: 7
  *       then: -> alert('welcome!')
  *       else: -> alert('welcome back!')
  */

  var onFirstVisit;
  return onFirstVisit = function(options) {
    if (!$.cookie('hide_title') || location.hash === '#welcome') {
      if (typeof options["else"] === "function") {
        options["else"]();
      }
    } else {
      if (typeof options.then === "function") {
        options.then();
      }
    }
    return $.cookie('hide_title', '1', {
      expires: options.days
    });
  };
});
// Generated by CoffeeScript 1.6.3
define('lib.scrollmonitor', function() {
  /*
  # Monitors scrolling and executes something on different breakpoints.
  #
  # monitor
  #   if: (y) -> y < 300
  #   enter: -> $('top').hide()
  #   exit: -> $('top').show()
  #   scroll: ->
  #
  */

  return function(options) {
    var $window, last, obj, update;
    last = null;
    $window = $(window);
    update = function() {
      var now, y;
      y = $window.scrollTop();
      now = options["if"](y);
      if (last !== now) {
        last = now;
        if (now && options.enter) {
          options.enter(y);
        } else if (!now && options.exit) {
          options.exit(y);
        }
      }
      if (options.scroll) {
        return options.scroll(y, now);
      }
    };
    obj = {
      update: update,
      status: function() {
        return last;
      },
      enable: function() {
        $window.on('resize', update);
        $window.on('scroll', update);
        this.update();
        return this;
      },
      disable: function() {
        $window.off('resize', update);
        $window.off('scroll', update);
        return this;
      }
    };
    return obj.enable();
  };
});
// Generated by CoffeeScript 1.6.3
define('locale.en', function() {
  return {
    services: {
      twitter: "Twitter",
      flickr: "Flickr",
      instagram: "Instagram",
      tumblr: "Tumblr"
    },
    posts: {
      twitter: "Tweets",
      flickr: "Flickr photos",
      instagram: "Instagram snapshots",
      tumblr: "Tumblr posts"
    }
  };
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
      entry.source()
      entry.source().name
      entry.source().service
    */


    Entry.prototype.source = function() {
      return this.get('source');
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

    Entry.prototype.isImage = function() {
      return this.typeClass() === 'image';
    };

    Entry.prototype.isText = function() {
      return this.typeClass() === 'text';
    };

    Entry.prototype.isVertical = function() {
      return this.ratio() < 0.8;
    };

    Entry.prototype.isHorizontal = function() {
      return this.ratio() > 1.2;
    };

    Entry.prototype.ratio = function() {
      return this.get('image_ratio') || 1;
    };

    Entry.prototype.slug = function() {
      return this.cid;
    };

    Entry.prototype.toString = function() {
      return this.get('text') || 'Entry';
    };

    /**
       date('ago')       #=> "3 days ago"
       date('long')      #=> September 16th, 2013
    */


    Entry.prototype.date = function(fmt) {
      if (fmt === 'ago') {
        return moment(this.get('date')).fromNow();
      } else {
        return moment(this.get('date')).format('MMMM Do, YYYY');
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

    Entries.prototype.findBySlug = function(slug) {
      return this.detect(function(entry) {
        return entry.cid === slug;
      });
    };

    return Entries;

  })(Backbone.Collection);
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('router.app', function() {
  var $html, AppRouter, EntryDialogView, L, _ref;
  $html = $('html');
  L = require('locale.en');
  EntryDialogView = require('view.entry_dialog');
  return AppRouter = (function(_super) {
    __extends(AppRouter, _super);

    function AppRouter() {
      _ref = AppRouter.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppRouter.prototype.routes = {
      '': 'home',
      'on/:service': 'service',
      'e/:slug': 'entry'
    };

    AppRouter.prototype.home = function() {
      App.loader.ping();
      this.title(null);
      this.klass("home");
      App.menuView.activate(null);
      return App.listView.filterBy(null);
    };

    AppRouter.prototype.service = function(service) {
      App.loader.ping();
      this.title(L.posts[service]);
      this.klass("service-" + service + " service");
      App.menuView.activate(service);
      return App.listView.filterBy(service);
    };

    AppRouter.prototype.entry = function(slug) {
      var entry, service;
      App.loader.ping();
      entry = Data.entries.findBySlug(slug);
      if (!entry) {
        alert("Unknown entry");
        return;
      }
      service = entry.source().name;
      this.title(entry.toString());
      App.menuView.activate(service);
      return new EntryDialogView({
        model: entry
      }).render();
    };

    /**
    * Changes the body class name.
    */


    AppRouter.prototype.klass = function(str) {
      var m;
      if (m = $html.data('mode')) {
        $html.removeClass(m);
      }
      return $html.addClass(str).data('mode', str);
    };

    /**
    * Changes title.
    */


    AppRouter.prototype.title = function(str) {
      if (str) {
        str = "" + str + " &mdash; MangoRed Slices";
      } else {
        str = "MangoRed Slices";
      }
      return $('title').html(str);
    };

    return AppRouter;

  })(Backbone.Router);
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

    EntryView.prototype.tagName = 'article';

    EntryView.prototype.className = 'entry-item';

    EntryView.prototype.initialize = function() {
      this.entry = this.options.entry;
      return this.index = this.options.index;
    };

    /** Renders the element
    */


    EntryView.prototype.render = function() {
      this.$el.html(this.template);
      this.renderClasses();
      this.renderCommon();
      this.renderSize();
      if (this.entry.isImage()) {
        this.renderImage();
      }
      return this;
    };

    /** Adds CSS classes
    */


    EntryView.prototype.renderClasses = function() {
      this.$el.addClass("entry-" + (this.entry.typeClass()));
      this.$el.addClass("service-" + (this.entry.source().name));
      return this.$el.addClass("text-" + (this.getLength()));
    };

    /** Renders common entries
    */


    EntryView.prototype.renderCommon = function() {
      this.$el.attr('role', 'entry');
      this.$(r('link')).attr({
        href: "#e/" + (this.entry.slug())
      });
      this.$(r('text')).html(this.entry.get('text'));
      this.$(r('date')).html(this.entry.date('long'));
      return this.$(r('date_ago')).html(this.entry.date('ago'));
    };

    /** Updates size classes (.w-1.h-2)
    */


    EntryView.prototype.renderSize = function() {
      var h, w, _ref1;
      _ref1 = this.getSize(), w = _ref1[0], h = _ref1[1];
      return this.$el.addClass("w" + w + " h" + h);
    };

    /** Returns grid size as a tuple (`[1, 3]` for 1x3)
    */


    EntryView.prototype.getSize = function() {
      if (this.index === 0) {
        return [2, 2];
      } else if (this.entry.isImage()) {
        if (this.entry.isVertical()) {
          return [1, 2];
        } else if (this.entry.isHorizontal()) {
          return [2, 1];
        } else if (Math.random() < 0.4) {
          return [2, 2];
        } else {
          return [1, 1];
        }
      } else {
        return [1, 1];
      }
    };

    /** Returns the length
    */


    EntryView.prototype.getLength = function() {
      var len;
      len = this.entry.get('text').length;
      if (len <= 60) {
        return 'short';
      } else if (len <= 110) {
        return 'medium';
      } else if (len <= 180) {
        return 'long';
      } else {
        return 'xlong';
      }
    };

    /** Renders an image type
    */


    EntryView.prototype.renderImage = function() {
      var src;
      src = this.entry.get('image');
      if (src) {
        this.$(r('image')).append($("<img>").attr({
          src: src
        }));
        return this.$(r('image')).fillsize("> img");
      }
    };

    /** HTML template
    */


    EntryView.prototype.template = "<a class='link' href='#' role='link'></a>\n<div class='image' role='image'>\n</div>\n<div class='meta'>\n  <div class='date' role='date'></div>\n  <div class='text' role='text'></div>\n  <div class='date-ago' role='date_ago'></div>\n</div>";

    return EntryView;

  })(Backbone.View);
});
// Generated by CoffeeScript 1.6.3
define('view.entry_dialog', function() {
  var EntryDialogView, r;
  r = function(role) {
    return "[role~='" + role + "']";
  };
  return EntryDialogView = (function() {
    function EntryDialogView(options) {
      if (options == null) {
        options = {};
      }
      this.model = options.model;
    }

    EntryDialogView.prototype.render = function() {
      var width;
      this.dialog = NDialog.open({
        html: this.template,
        "class": 'entry-dialog'
      });
      width = 600;
      this.$el = this.dialog.$el;
      this.$el.find(r('image')).attr({
        src: this.model.get('image_large') || this.model.get('image'),
        width: width,
        height: width * parseFloat(this.model.get('image_ratio'), 10)
      });
      this.$el.find(r('title')).text(this.model.toString());
      this.$el.find(r('date')).text(this.model.date('ago'));
      this.dialog.on('close', function() {
        return history.back();
      }).reposition();
      return this;
    };

    EntryDialogView.prototype.template = "<div>\n  <button class='close' role='close'></button>\n  <div class='image'>\n    <img src='' role='image'>\n  </div>\n  <div class='meta'>\n    <div class='right' role='date'>\n    </div>\n    <div class='left' role='title'>\n    </div>\n  </div>\n</div>";

    return EntryDialogView;

  })();
});
// Generated by CoffeeScript 1.6.3
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('view.list', function() {
  var EntryView, ListView, r, _ref;
  r = function(role) {
    return "[role~='" + role + "']";
  };
  EntryView = require('view.entry');
  /**
    List view.
  
    Common usage:
  
        App.listView.filterBy('instagram')
        App.listView.filterBy(null)
  */

  return ListView = (function(_super) {
    __extends(ListView, _super);

    function ListView() {
      this.filterBy = __bind(this.filterBy, this);
      this.add = __bind(this.add, this);
      this.reset = __bind(this.reset, this);
      _ref = ListView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ListView.prototype.el = $(r('list_view'));

    /** Entries collection*/


    ListView.prototype.entries = null;

    /** Masonry instance*/


    ListView.prototype.masonry = null;

    /** Constructor
    */


    ListView.prototype.initialize = function() {
      this.entries = Data.entries;
      return this.listenTo(this.entries, {
        'reset': this.reset,
        'add': this.add
      });
    };

    ListView.prototype.render = function() {
      this.$el.masonry({
        itemSelector: "article"
      });
      return this;
    };

    /** Removes all entries.
    */


    ListView.prototype.reset = function(entries) {
      var _this = this;
      this.$el.html("");
      return entries.each(function(entry) {
        return _this.add(entry);
      });
    };

    /** Adds an entry.
    */


    ListView.prototype.add = function(entry) {
      var $ph, i, view;
      i = this.$el.children().length;
      view = new EntryView({
        entry: entry,
        index: i
      });
      this.$el.append(view.render().el).masonry('appended', view.$el);
      if (Math.random() < 0.3) {
        $ph = $("<article class='entry-item h1 w1 placeholder'></article>");
        this.$el.append($ph).masonry('appended', $ph);
      }
      return this.relayout();
    };

    ListView.prototype.filterBy = function(service) {
      if (service) {
        this.$(r('entry')).hide();
        this.$(r('entry')).filter(".service-" + service).show();
      } else {
        this.$(r('entry')).show();
      }
      return this.relayout();
    };

    /** Update layouts*/


    ListView.prototype.relayout = function() {
      this.$el.masonry();
      return this.$el.trigger('fillsize');
    };

    return ListView;

  })(Backbone.View);
});
// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('view.menu', function() {
  var MenuView, r, _ref;
  r = function(role) {
    return "[role~='" + role + "']";
  };
  /**
  
  Usage:
  
      App.menuView.activate('instagram')
      App.menuView.activate(null)
  */

  return MenuView = (function(_super) {
    __extends(MenuView, _super);

    function MenuView() {
      _ref = MenuView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    MenuView.prototype.el = $(r('menu'));

    MenuView.prototype.activate = function(service) {
      this.$('a').removeClass('active');
      if (service) {
        return this.$("a.link-" + service).addClass('active');
      }
    };

    return MenuView;

  })(Backbone.View);
});
// Generated by CoffeeScript 1.6.3
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('view.title', function() {
  var TitleView, monitor, r, _ref;
  r = function(role) {
    return "[role~='" + role + "']";
  };
  monitor = require('lib.scrollmonitor');
  return TitleView = (function(_super) {
    __extends(TitleView, _super);

    function TitleView() {
      this.pinHeight = __bind(this.pinHeight, this);
      this.getMonitor = __bind(this.getMonitor, this);
      this.update = __bind(this.update, this);
      _ref = TitleView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    TitleView.prototype.el = $(r('title_view'));

    TitleView.prototype.minHeight = 100;

    TitleView.prototype.render = function() {
      $(window).on('resize.titleview', this.update);
      this.update();
      this.getMonitor();
      return this;
    };

    TitleView.prototype.height = function() {
      return Math.max(this.minHeight, $(window).height());
    };

    TitleView.prototype.update = function() {
      return this.$el.css({
        height: this.height()
      });
    };

    TitleView.prototype.getMonitor = function() {
      var timer,
        _this = this;
      if (!$('html').is('.desktop')) {
        return;
      }
      timer = null;
      return this.monitor = monitor({
        "if": function(y) {
          return y < _this.$el.outerHeight();
        },
        enter: function(y) {
          _this.pinHeight();
          $('html').addClass('pinned');
          return timer = setInterval(_this.pinHeight, 1500);
        },
        exit: function(y) {
          var height;
          $('html').removeClass('pinned');
          $('html').css({
            height: 'auto'
          });
          if (timer) {
            clearInterval(timer);
          }
          height = _this.$el.outerHeight();
          _this.remove();
          _this.monitor.disable();
          return $(window).scrollTop(y - height);
        }
      });
    };

    TitleView.prototype.pinHeight = function() {
      var h, pinned;
      pinned = $('html').is('.pinned');
      if (pinned) {
        $('html').removeClass('pinned');
        $('html').outerHeight;
      }
      h = $(document).height();
      if (pinned) {
        $('html').addClass('pinned');
        $('html').outerHeight;
      }
      $('html').css({
        height: h
      });
      return h;
    };

    return TitleView;

  })(Backbone.View);
});
// Generated by CoffeeScript 1.6.3
$(function() {
  var App, Data;
  Data = window.Data = {};
  Data.entries = new (require('collection.entries'));
  Data.accounts = new (require('collection.accounts'));
  App = window.App = {};
  App.nav = function(url) {
    return Backbone.history.navigate(url, {
      trigger: true
    });
  };
  App.config = require('app.config');
  App.loader = new (require('app.loader'));
  App.router = new (require('router.app'));
  return App.fetcher = new (require('app.fetcher'));
});

$(function() {
  var isMobile, onFirstVisit,
    _this = this;
  isMobile = navigator.userAgent.match(/iPod|iPad|iPhone|Android/);
  $('html').addClass(isMobile ? 'mobile' : 'desktop');
  onFirstVisit = require('lib.onfirstvisit');
  App.listView = new (require('view.list'))().render();
  App.menuView = new (require('view.menu'));
  onFirstVisit({
    days: 7,
    then: function() {
      return $('[role~="title_view"]').remove();
    },
    "else": function() {
      return App.titleView = new (require('view.title'))().render();
    }
  });
  return App.loader.load(App.fetcher.fetch().done(function() {
    return Backbone.history.start();
  }));
});
