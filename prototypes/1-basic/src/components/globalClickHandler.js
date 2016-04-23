// All callbacks require (x:Float, y:Float) as inputs
Crafty.c('GlobalClickHandler', {

    init: function() {
        var self = this;

        // First array = event we're binding to, eg. Click
        // Second array = our callback function
        this.eventHandlers = [];
        this.callbacks = [];


        self.mouseUpCallback = null;

        this.requires('2D, Alpha, Canvas, Mouse, FollowCamera')
            .attr({ w: Game.view.width, h: Game.view.height });
    },

    clear: function()
    {
      for (var i = 0; i < this.eventHandlers.length; i++)
      {
        this.unbind(this.eventHandlers[i], this.callbacks[i]);
      }
    },

    onMove: function(callback) {
        var onMove = function(e) {
            callback(e.realX, e.realY);
        }
        this.trackEvent('MouseMove', onMove);
        return this;
    },

    onClick: function(callback) {
        var callback = function(e) {
            callback(e.realX, e.realY);
        };
        trackEvent('Click', callback);
        return this;
    },

    onMouseUp: function(callback) {
        this.mouseUpCallback = callback;
        return this;
    },

    whileMouseDown: function(callback) {
        var self = this;
        self.isMouseDown = false;
        self.mouseCoordinates = [0, 0];

        var mouseDown = function(e) {
            self.isMouseDown = true;
            callback(e.realX, e.realY);
        };

        this.trackEvent('MouseDown', mouseDown);

        var mouseUp = function(e) {
            self.isMouseDown = false;
            self.mouseCoordinates = [e.realX, e.realY];
            if (self.mouseUpCallback != null) {
                self.mouseUpCallback(e.realX, e.realY);
            }
        };

        this.trackEvent('MouseUp', mouseUp)

        var mouseMove = function(e) {
            self.mouseCoordinates = [e.realX, e.realY];
        };

        this.trackEvent('MouseMove', mouseMove);

        var enterFrame = function() {
            if (self.isMouseDown) {
                callback(self.mouseCoordinates[0], self.mouseCoordinates[1]);
            }
        };

        this.trackEvent('EnterFrame', enterFrame);

        return this;
    },

    trackEvent: function(event, callback) {
      this.bind(event, callback);
      this.eventHandlers.push(event);
      this.callbacks.push(callback);
    }
});
