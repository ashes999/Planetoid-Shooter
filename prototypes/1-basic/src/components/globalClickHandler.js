Crafty.c('GlobalClickHandler', {
    init: function() {
        var self = this;
        this.requires('2D, Alpha, Canvas, Mouse, FollowCamera')
            .attr({ w: Game.view.width, h: Game.view.height })
            .bind('Click', function(e) {
                if (this.clickFunction != null) {
                    this.clickFunction(e.realX, e.realY);
                }
            });
    },

    onMove: function(callback) {
        this.moveFunction = callback;
        this.bind('MouseMove', function(e) {
            callback(e.realX, e.realY);
        });
        return this;
    },

    onClick: function(callback) {
        this.clickFunction = callback;
        return this;
    }
});
