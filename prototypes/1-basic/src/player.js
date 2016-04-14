Crafty.c('Player', {
    init: function() {
        this.health = 100;
        this.lastHurtByLava = Date.now();
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
        Crafty.e('MachineGun');
        
        Crafty.bind('MouseWheelScroll', function() {
            if (Crafty.first('PlasmaGun') != null) {
                Crafty.single('PlasmaGun').die();
                Crafty.e('MachineGun');
            } else if (Crafty.first('MachineGun') != null) {
                Crafty.single('MachineGun').die();
                Crafty.e('PlasmaGun');
            }
        })
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
