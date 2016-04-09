Crafty.c('Player', {
    init: function() {
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
    }
});
