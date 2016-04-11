Crafty.c('Player', {
    init: function() {
        this.health = 100;
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
    },
    getHurt: function(damage) {
        this.health -= damage;
        this.health = Math.max(this.health, 0);
        Crafty.single('HealthBar').update(this.health);

        if (this.health == 0) {
            this.die();
            Crafty.single('Gun').die();
            Crafty.single('Stats').showGameOver();
        }
    }
});
