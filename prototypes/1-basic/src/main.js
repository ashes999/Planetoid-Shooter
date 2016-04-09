Game = {
    world: {
        width: 1600,
        height: 1200
    },

    // This defines our grid's size and the size of each of its tiles
    view: {
        width: 800,
        height: 600,
    },

    start: function() {
        Crafty.init(Game.view.width, Game.view.height);
        loadImages(["images/background.jpg"], function() {
            Crafty.e('Actor').img('images/background.jpg', "repeat")
                .move(0, 0).size(Game.world.width, Game.world.height)
                .z = -1;
        });

        var p = Crafty.e('Player');
        Crafty.viewport.clampEntities = false;
        var scale = Math.min(Game.world.width / Game.view.width, Game.world.height / Game.view.height);
        //Crafty.viewport.scale(scale);

        //Crafty.viewport.width = Game.view.width;
        //Crafty.viewport.height = Game.view.height;
        Crafty.viewport.follow(p);


    }
}

window.addEventListener('load', Game.start);
