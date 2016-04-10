Crafty.c('MeteorManager', {
    init: function() {
        var manager = this;
        this.lastSpawn = Date.now();
        this.requires('Actor').size(0, 0).bind('EnterFrame', function() {
            var monsterCount = Crafty('Monster').length;
            var now = Date.now();
            if (monsterCount == 0 && now - manager.lastSpawn >= 3000) { // 3s
                Crafty.e('Actor').size(0, 0).after(1, function() {
                    Crafty.e('Meteor');
                })
                manager.lastSpawn = now;
            }
        });
    }
});
