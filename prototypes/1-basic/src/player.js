Crafty.c('Player', {
    init: function() {
        this.health = 100;
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
        Crafty.e('MachineGun');
    },
    getHurt: function(damage) {
        this.health -= damage;
        this.health = Math.max(this.health, 0);
        Crafty.single('HealthBar').update(this.health);

        if (this.health == 0) {
            this.die();
            Crafty.single('BaseGun').die();
            Crafty.single('Stats').showGameOver();
        }
    }
});
