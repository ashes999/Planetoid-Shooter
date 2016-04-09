Crafty.c('HealthBar', {
    init: function() {
        this.requires('Actor, Text2, FollowCamera').size(100, 16).text('Health: 100');        
    },
    update: function(health) {
        this.text('Health: ' + health);
    }
});
