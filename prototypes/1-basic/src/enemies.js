Crafty.c('Meteor', {
    init: function() {
        this.requires('Actor').size(400, 400).color('#444444');
        var x = randomBetween(0, Game.world.width - 48);
        var y = randomBetween(0, Game.world.height - 48);
        this.rotation = randomBetween(0, 180);
        this.move(x, y);
        this.tween({ 'w': 64, 'h': 64, rotation: 0 }, 0.25);
        var meteor = this;

        this.one('TweenEnd', function() {
            console.log("A meteor lands!");
            for (var i = 0; i < randomBetween(config('min_meteor_monsters'), config('max_meteor_monsters')); i++) {
                Crafty.e('Monster').spawn(meteor);
            }
        });
    }
});

Crafty.c('Monster', {
    init: function() {
        this.requires('Actor').color('#224488').size(20, 20);
        this.damage = config('monster_damage');
        
        var monster = this;
        this.collide('Player', function() {
            monster.die();
            Crafty(Crafty('Player')[0]).getHurt(monster.damage);
        })
    },

    spawn: function(meteor) {
        this.speed = randomBetween(config('monster_velocity_min'), config('monster_velocity_max'));

        // Pick distance
        var xDistance = randomBetween(50, 100);
        var yDistance = randomBetween(25, 50);

        if (randomBetween(0, 100) <= 50) {
            xDistance *= -1;
        }
        if (randomBetween(0, 100) <= 50) {
            yDistance *= -1;
        }

        this.x = meteor.x + xDistance + (xDistance > 0 ? meteor.w : 0);
        this.y = meteor.y + yDistance + (yDistance > 0 ? meteor.h : 0);
        var self = this;
        var player = Crafty(Crafty('Player')[0]);

        this.bind('EnterFrame', function() {
            var distance = Math.pow(Math.abs(self.x - player.x), 2) + Math.pow(Math.abs(self.y - player.y), 2);
            distance = Math.pow(distance, 0.5);
            var travelTime = distance / self.speed;
            this.move(player.x, player.y, travelTime);
        })
    }
})
