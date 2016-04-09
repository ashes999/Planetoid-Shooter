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
        this.bind('EnterFrame', function() {
            var player = Crafty(Crafty('Player')[0]);
            gun.move(player.x + player.attr('w') / 2, player.y + (player.attr('h') / 2));
        });

        Crafty.e('GlobalClickHandler')
            .onClick(function(x, y) {
                console.log("FIRE: " + x + ", " + y);
            })
            .onMove(function(x, y) {
                var gun = Crafty(Crafty('Gun')[0]);
                var dx = x - gun.x;
                var dy = y - gun.y;

                // http://stackoverflow.com/questions/7586063/how-to-calculate-the-angle-between-a-line-and-the-horizontal-axis
                var angle = Math.atan2(dy, dx) * 180 / Math.PI;
                gun.rotation = angle;
            });
    }
})
