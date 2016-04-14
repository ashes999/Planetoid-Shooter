Crafty.c('Stats', {
   init: function() {
       this.wave = 0;
       this.monstersKilled = 0;
       this.meteorsSeen = 0;
   },
   
   showGameOver: function() {
       Crafty.e('Text2, FollowCamera').move(100, 100).fontSize(48).text('GAME OVER!');
       console.log('You reached wave ' + this.wave);
       console.log("Meteors Seen: " + this.meteorsSeen);
       console.log("Monsters Killed: " + this.monstersKilled);       
   }
});