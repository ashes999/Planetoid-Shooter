Crafty.c('FollowCamera', {
    init: function() {
        var self = this;
        // Move with the viewport
        this.bind('EnterFrame', function() {
            self.x = -Crafty.viewport.x;
            self.y = -Crafty.viewport.y;
        });
    }
});
