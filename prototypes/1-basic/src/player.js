Crafty.c('Player', {
    init: function() {
        this.health = 100;
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
    },
    getHurt: function(damage) {
        this.health -= damage;
        this.health = Math.max(this.health, 0);
        Crafty(Crafty('HealthBar')[0]).update(this.health);
    }
});
