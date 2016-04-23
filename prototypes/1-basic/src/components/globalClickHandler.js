// All callbacks require (x:Float, y:Float) as inputs
Crafty.c('GlobalClickHandler', {
    init: function() {
        var self = this;
        self.mouseUpCallback = null;

        this.requires('2D, Alpha, Canvas, Mouse, FollowCamera')
            .attr({ w: Game.view.width, h: Game.view.height });
    },

    clear: function()
    {
        this.unbind('MouseMove').unbind('Click').unbind('MouseDown')
          .unbind('MouseUp').unbind('EnterFrame');
    },

    onMove: function(callback) {
        this.bind('MouseMove', function(e) {
            callback(e.realX, e.realY);
        });
        return this;
    },

    onClick: function(callback) {
        this.bind('Click', function(e) {
            callback(e.realX, e.realY);
        });
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

        this.bind('MouseDown', function(e) {
            self.isMouseDown = true;
            callback(e.realX, e.realY);
        });

        this.bind('MouseUp', function(e) {
            self.isMouseDown = false;
            self.mouseCoordinates = [e.realX, e.realY];
            if (self.mouseUpCallback != null) {
                self.mouseUpCallback(e.realX, e.realY);
            }
        });

        this.bind('MouseMove', function(e) {
            self.mouseCoordinates = [e.realX, e.realY];
        });

        this.bind('EnterFrame', function() {
            if (self.isMouseDown) {
                callback(self.mouseCoordinates[0], self.mouseCoordinates[1]);
            }
        });

        return this;
    }
});
