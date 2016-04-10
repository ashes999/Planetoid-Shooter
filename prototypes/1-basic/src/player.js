Crafty.c('Player', {
    init: function() {
        this.health = 100;
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
    },
    getHurt: function(damage) {
        this.health -= damage;
        this.health = Math.max(this.health, 0);
        Crafty(Crafty('HealthBar')[0]).update(this.health);

        if (this.health == 0) {
            this.die();
            Crafty(Crafty('Gun')[0]).die();
            Crafty(Crafty('Stats')[0]).showGameOver();
        }
    }
});
