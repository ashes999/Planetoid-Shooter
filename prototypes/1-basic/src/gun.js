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

Crafty.c('Gun', {
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

    fire: function()
    {
        var gun = Crafty.first('Gun');
        var player = Crafty.first('Player');
        if (gun == null || player == null) { return; }

        var now = Date.now();
        // gun_shot_rate_ms is in milliseconds
        if ((now - gun.lastShot) > config('gun_shot_rate_ms')) {
            gun.lastShot = now;
            
            var angleInRadians = gun.rotation * Math.PI / 180;
            var vx = config('bullet_speed') * Math.cos(angleInRadians);
            var vy = config('bullet_speed') * Math.sin(angleInRadians);

            Crafty.e('Bullet')
                // I can't do math right now. Start on player center.
                .move(player.x + (player.w / 2), player.y + (player.h / 2))
                .velocity(vx, vy);
        }
    }
});


Crafty.c('Bullet', {
    init: function() {
        var bullet = this;
        this.damage = config('bullet_damage');
        this.requires('Actor').color('white').size(8, 8)
            .collide(['Wall'], function() {
                bullet.die();
            }).collide('Monster', function(data) {
                var monster = data[0].obj;
                monster.getHurt(bullet.damage);
                bullet.die();
            });
    }
});
