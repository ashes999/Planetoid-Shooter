Crafty.c('Stats', {
   init: function() {
       this.monstersKilled = 0;
       this.meteorsSeen = 0;
   },
   
   showGameOver: function() {
       Crafty.e('Text2, FollowCamera').move(100, 100).fontSize(72).text('GAME OVER!');
       console.log("Meteors Seen: " + this.meteorsSeen);
       console.log("Monsters Killed: " + this.monstersKilled);       
   }
});