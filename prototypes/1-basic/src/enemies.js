Crafty.c('Meteor', {
    init: function() {
        this.requires('Actor').size(400, 400).color('#444444');
        var x = randomBetween(0, Game.world.width - 48);
        var y = randomBetween(0, Game.world.height - 48);
        this.rotation = randomBetween(0, 180);
        this.move(x, y);
        this.tween({ 'w': 64, 'h': 64, rotation: 0 }, 0.25);
        console.log("A meteor lands!");
    }
});
