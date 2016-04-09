Game = {
    // This defines our grid's size and the size of each of its tiles
    view: {
        width: 800,
        height: 600,
    },

    start: function() {
        Crafty.init(800, 600);
        Crafty.background("#bbb");
        var p = Crafty.e('Player');
        Crafty.viewport.centerOn(p);
        
        // Global mouse click handler
        var self = Crafty.e('2D, Alpha, Canvas, Mouse').attr({ w: Game.view.width, h: Game.view.height })
            .bind('Click', function(e) {
                console.log('click: ' + JSON.stringify(e));
            })
            .bind('EnterFrame', function() {
               self.x = -Crafty.viewport.x;
               self.y = -Crafty.viewport.y; 
            });
    }
}

window.addEventListener('load', Game.start);
