Game = {
    world: {
        width: 1000,
        height: 800
    },

    // This defines our grid's size and the size of each of its tiles
    view: {
        width: 800,
        height: 600,
    },

    start: function() {
        loadImages(["images/background.jpg"], function() {
            Crafty.init(Game.view.width, Game.view.height);

            Crafty.e('Actor').img('images/background.jpg', "repeat")
                .move(0, 0).size(Game.world.width, Game.world.height)
                .z = -1;

            // World-bounds walls
            Crafty.e('Wall').size(Game.world.width, 1).move(0, 0); // top
            Crafty.e('Wall').size(Game.world.width, 1).move(0, Game.world.height); // bottom
            Crafty.e('Wall').size(1, Game.world.height).move(0, 0); // left
            Crafty.e('Wall').size(1, Game.world.height).move(Game.world.width, 0); // right

            // Allow map to be bigger than what fits on canvas
            Crafty.viewport.clampEntities = false;

            if (config('zoom') != undefined) {
                // Zoom looks cool!
                Crafty.viewport.scale(1.5);
            }

            // Follow player
            var p = Crafty.e('Player');
            Crafty.viewport.follow(p);
            Crafty.e('Gun');
            
        });
    }
}

window.addEventListener('load', Game.start);
