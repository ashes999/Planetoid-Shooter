Game = {
    // This defines our grid's size and the size of each of its tiles
    view: {
        width: 800,
        height: 600,
    },

    start: function() {
        Crafty.init(Game.view.width, Game.view.height);
        Crafty.background("#eeeeee");
        Crafty.e('Actor').controllable(100);;
    }
}

window.addEventListener('load', Game.start);
