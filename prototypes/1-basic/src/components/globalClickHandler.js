Crafty.c('GlobalClickHandler', {
    init: function() {
        var self = this;
        this.requires('2D, Alpha, Canvas, Mouse, FollowCamera')
            .attr({ w: Game.view.width, h: Game.view.height });
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
