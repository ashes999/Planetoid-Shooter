Game = {
    world: {
        width: 800,
        height: 600
    },
    
    // This defines our grid's size and the size of each of its tiles
    view: {
        width: 400,
        height: 300,
    },

    start: function() {
        Crafty.init(Game.world.width, Game.world.height);
        loadImages(["images/background.jpg"], function() {
            Crafty.e('Actor').img('images/background.jpg').move(0, 0).size(Game.world.width, Game.world.height).z = -1;
        });
        
        var p = Crafty.e('Player');
        //Crafty.viewport.width = Game.view.width;
        //Crafty.viewport.height = Game.view.height;
        Crafty.viewport.centerOn(p);
    }
}

window.addEventListener('load', Game.start);
