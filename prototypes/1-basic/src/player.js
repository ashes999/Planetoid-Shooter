Crafty.c('Player', {
    init: function() {
        this.requires('Actor').color('red').controllable(100).collideWith('Wall');
    }
});

Crafty.c('Gun', {
    init: function() {
        this.requires('Actor').color('black').size(16, 2);
        this.z = 100;

        var gun = this;
        var player = Crafty(Crafty('Player')[0]);

        this.bind('EnterFrame', function() {
            gun.move(player.x + player.w / 2, player.y + (player.h / 2));
        });

        Crafty.e('GlobalClickHandler')
            .onClick(function(x, y) {
                var angleInRadians = gun.rotation * Math.PI / 180;
                var vx = config('bullet_speed') * Math.cos(angleInRadians);
                var vy = config('bullet_speed') * Math.sin(angleInRadians);
                
                Crafty.e('Bullet')
                    // I can't do math right now. Start on player center.
                    .move(player.x + (player.w / 2), player.y + (player.h / 2))
                    .velocity(vx, vy);
            })
            .onMove(function(x, y) {
                var dx = x - gun.x;
                var dy = y - gun.y;

                // http://stackoverflow.com/questions/7586063/how-to-calculate-the-angle-between-a-line-and-the-horizontal-axis
                var angle = Math.atan2(dy, dx) * 180 / Math.PI;
                gun.rotation = angle;
            });
    }
});

Crafty.c('Bullet', {
    init: function() {
        this.requires('Actor').color('white').size(8, 8);
    }
});
