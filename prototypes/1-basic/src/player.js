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

Crafty.c('Gun', {
    init: function() {
        this.requires('Actor').color('black').size(16, 2);
        this.z = 100;
        this.lastShot = Date.now() - 1000; // 1s ago

        var gun = this;
        var player = Crafty(Crafty('Player')[0]);

        this.bind('EnterFrame', function() {
            gun.move(player.x + player.w / 2, player.y + (player.h / 2));
        });

        Crafty.e('GlobalClickHandler')
            .whileMouseDown(function(x, y) {
                gun.fire();
            })
            .onMove(function(x, y) {
                var dx = x - gun.x;
                var dy = y - gun.y;

                // http://stackoverflow.com/questions/7586063/how-to-calculate-the-angle-between-a-line-and-the-horizontal-axis
                var angle = Math.atan2(dy, dx) * 180 / Math.PI;
                gun.rotation = angle;
            });
    },

    fire: function()
    {
        var gun = Crafty(Crafty('Gun')[0]);
        var player = Crafty(Crafty('Player')[0]);

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
        this.requires('Actor').color('white').size(8, 8);
    }
});
