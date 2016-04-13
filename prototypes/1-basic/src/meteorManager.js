Crafty.c('MeteorManager', {
    init: function() {
        var manager = this;
        this.lastSpawn = Date.now();
        this.requires('Actor').size(0, 0).bind('EnterFrame', function() {
            var monsterCount = Crafty('Monster').length;
            var now = Date.now();
            if (monsterCount == 0 && now - manager.lastSpawn >= 3000) { // 3s after the last meteor
                Crafty.single('Stats').wave += 1;
                var numMeteors = randomBetween(1, config('max_meteors_per_wave') + 1);
                if (Crafty.single('Stats').wave == 1) {
                    numMeteors = 1;
                }
                for (var i = 0; i < numMeteors; i++) {
                    // space them 3s apart
                    Crafty.e('Actor').size(0, 0).after((3*i) + 1, function() {
                        Crafty.e('Meteor');
                    });
                }
                manager.lastSpawn = now;
            }
        });
    }
});
