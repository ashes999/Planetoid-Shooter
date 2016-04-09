Crafty.c('GlobalClickHandler', {
    init: function() {
        var self = this;
        this.requirese('2D, Alpha, Canvas, Mouse')
            .attr({ w: Game.view.width, h: Game.view.height })
            .bind('Click', function(e) {
                console.log('click: ' + JSON.stringify(e));
            })
            .bind('EnterFrame', function() {
                self.x = -Crafty.viewport.x;
                self.y = -Crafty.viewport.y; 
            });
    }
});