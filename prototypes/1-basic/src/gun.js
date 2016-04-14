// Base class, don't instantiate
Crafty.c('BaseGun', {
    init: function() {
        this.requires('Actor').color('grey').size(4, 2);
        this.z = 100;

        var gun = this;
        var player = Crafty.single('Player');

        this.bind('EnterFrame', function() {
            gun.move(player.x + player.w / 2, player.y + (player.h / 2));
        });

        Crafty.e('GlobalClickHandler')
            .onMove(function(x, y) {
                var dx = x - gun.x;
                var dy = y - gun.y;

                // http://stackoverflow.com/questions/7586063/how-to-calculate-the-angle-between-a-line-and-the-horizontal-axis
                var angle = Math.atan2(dy, dx) * 180 / Math.PI;
                gun.rotation = angle;
            });
    }
});

Crafty.c('MachineGun', {
    init: function() {
        this.requires('BaseGun').color('black').size(16, 2);
        this.lastShot = Date.now() - 1000; // 1s ago

        var gun = this;
        var player = Crafty.single('Player');

        Crafty.single('GlobalClickHandler')
            .whileMouseDown(function(x, y) {
                gun.fire();
            })
    },

    fire: function() {
        var gun = Crafty.first('BaseGun');
        var player = Crafty.first('Player');
        if (gun == null || player == null) { return; }

        var now = Date.now();
        // gun_shot_rate_ms is in milliseconds
        if ((now - gun.lastShot) > config('gun_shot_rate_ms')) {
            gun.lastShot = now;
            
            var angleInRadians = gun.rotation * Math.PI / 180;
            var vx = config('bullet_speed') * Math.cos(angleInRadians);
            var vy = config('bullet_speed') * Math.sin(angleInRadians);

            Crafty.e('GunBullet').velocity(vx, vy)
                .move(player.x + (player.w / 2), player.y + (player.h / 2));
        }
    }
});

Crafty.c('PlasmaGun', {
    init: function() {
        this.charges = 0;
        this.bullet = null;
        
        this.requires('BaseGun').color('orange').size(10, 6);

        var gun = this;
        var player = Crafty.single('Player');

        Crafty.single('GlobalClickHandler')
            .whileMouseDown(function(x, y) {
                gun.charge();
            }).onMouseUp(function(x, y) {
               gun.fire(); 
            });
    },
    
    charge: function() {
        var gun = this;
        var player = Crafty.first("Player");
        if (player == null) { return; }
        
        if (this.bullet == null) {
            var bullet = Crafty.e('PlasmaBullet');
            bullet.bind('EnterFrame', this.centerOverPlayer);
            this.bullet = bullet;
        }
        
        this.charges = Math.min(this.charges + 1, 40);
    },

    fire: function() {
        if (this.charges >= 10) {
            this.bullet.unbind('EnterFrame', this.centerOverPlayer);
            
            var gun = Crafty.first('PlasmaGun');
            var player = Crafty.first('Player');
            if (gun == null || player == null) { return; }
                
            var angleInRadians = gun.rotation * Math.PI / 180;
            var vx = config('plasma_speed') * Math.cos(angleInRadians);
            var vy = config('plasma_speed') * Math.sin(angleInRadians);
            this.bullet.velocity(vx, vy);
        } else {
            this.bullet.die();
        }
        
        this.charges = 0;        
        this.bullet = null;
    },
    
    centerOverPlayer: function() {
        var player = Crafty.first("Player");
        var gun = Crafty.first("PlasmaGun"); 
        var bullet = Crafty.last("PlasmaBullet");
        if (player == null || gun == null) { return; }
        bullet.move(player.x + ((player.w - bullet.w) / 2), player.y - 8 - bullet.h);
        bullet.size(8 + gun.charges, 8 + gun.charges);
    }
});


Crafty.c('Bullet', {
    init: function() {
        var bullet = this;
        this.damage = config('bullet_damage');
        this.z = -100;
        this.requires('Actor')
            .collide(['Wall'], function() {
                bullet.die();
            }).collide('Monster', function(data) {
                var monster = data[0].obj;
                var now = Date.now();
                if (monster.wasntHurtBy(bullet))
                {
                    monster.getHurt(bullet);
                }
            });
    }
});

Crafty.c('GunBullet', {
   init: function() {
       var bullet = this;
       this.requires('Bullet').color('white').size(8, 8)
        .collide('Monster', function(data) {
            bullet.die();
        });
   }
});

Crafty.c('PlasmaBullet', {
   init: function() {
       this.requires('Bullet').color('yellow').size(8, 8);
       this.damage = config('plasma_damage');
       this.move(50, 50); // without this, bullet is stuck behind a wall
   } 
});