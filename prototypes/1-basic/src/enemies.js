Crafty.c('Meteor', {
    init: function() {
        this.requires('Actor').size(400, 400).color('#444444');
        var x = randomBetween(0, Game.world.width - 48);
        var y = randomBetween(0, Game.world.height - 48);
        this.rotation = randomBetween(90, 270);
        this.move(x, y);
        this.tween({ 'w': 64, 'h': 64, rotation: 0 }, 0.25);

        var meteor = this;
        this.lastHurtPlayer = Date.now() - 1000; // 1s ago
        this.landed = false;

        this.one('TweenEnd', function() {
            console.log("A meteor lands!");
            Crafty.single('Stats').meteorsSeen++;
            meteor.landed = true;
            
            var numMonsters = randomBetween(config('min_meteor_monsters'), config('max_meteor_monsters'));
            for (var i = 0; i < numMonsters; i++) {
                Crafty.e('Monster').spawnAround(meteor);
            }
            
            meteor.randomMonstersLeft = randomBetween(config('min_meteor_extra_monsters'), config('max_meteor_extra_monsters'));
            meteor.nextRandomMonster = Date.now() + randomBetween(5000, 10000); //5-10s later
            
            meteor.bind('EnterFrame', function() {
                if (meteor.randomMonstersLeft > 0 && Date.now() > meteor.nextRandomMonster) {
                    Crafty.e('Monster').move(meteor.x + (meteor.w / 2), meteor.y + (meteor.h / 2));
                    meteor.randomMonstersLeft -= 1;
                    meteor.nextRandomMonster = Date.now() + randomBetween(5000, 10000); //5-10s later
                }
            });
            
            meteor.color('#ff9911');
        });

        this.collide('Player', function(data) {
            if (meteor.landed == true) {
                var now = Date.now();
                if (now - meteor.lastHurtPlayer >= 1000) { // 1s
                    meteor.lastHurtPlayer = now;
                    data[0].obj.getHurt(config('lava_damage'));
                }
            }
        });
    }
});

Crafty.c('Monster', {
    init: function() {
        this.requires('Actor').color('#224488').size(20, 20);
        this.hurtBy  = []; // bullets
        this.damage = config('monster_damage');
        this.health = randomBetween(config('min_monster_health'), config('max_monster_health'));

        var monster = this;
        this.collide('Player', function() {
            monster.die();
            Crafty.single('Player').getHurt(monster.damage);
        });
        
        this.speed = randomBetween(config('monster_velocity_min'), config('monster_velocity_max'));
        
        // Track the player. Clever trick uses a fixed velocity
        // to calculate travel time, then move the appropriate distance.
        this.bind('EnterFrame', function() {
            var player = Crafty.first('Player');
            if (player == null) { return; }
            
            // root(x^2 + y^2)
            var distance = Math.pow(Math.abs(monster.x - player.x), 2) +
                Math.pow(Math.abs(monster.y - player.y), 2);
            distance = Math.pow(distance, 0.5);
            
            var travelTime = distance / monster.speed;
            monster.move(player.x, player.y, travelTime);
        })
    },

    getHurt: function(bullet) {
        this.hurtBy.push(bullet);
        this.health -= bullet.damage;
        if (this.health <= 0) {
            Crafty.single('Stats').monstersKilled++;            
            this.die();            
        }
    },
    
    wasntHurtBy: function(bullet) {
        return this.hurtBy.indexOf(bullet) == -1;
    },

    // Spawn close to a meteor
    spawnAround: function(meteor) {

        // Pick distance to meteor
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
    }
})

Crafty.c('Lava', {
    init: function() {
        var s = randomBetween(20, 35);
        this.requires('Actor').size(s, s).color('#ff6600');
        var lava = this;
        this.collide('Player', function(data) {
            var player = data[0].obj;
            var now = Date.now();
            if (now - player.lastHurtByLava >= 1000) {
                player.getHurt(config('lava_damage'));
                player.lastHurtByLava = now;
            }
        });
        
        // Fix performance problem caused by too much lava over time
        var lavaTime = randomBetween(config('lava_min_time'), config('lava_max_time'));
        this.tween({ w: 0, h: 0 }, lavaTime).bind('TweenEnd', function() { lava.die(); });
    }
});