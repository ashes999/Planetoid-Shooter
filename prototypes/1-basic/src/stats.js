Crafty.c('Stats', {
   init: function() {
       this.monstersKilled = 0;
       this.meteorsSeen = 0;
       this.bulletsFired = 0;
       this.bulletsHit = 0;
   },
   
   getAccuracy: function() {
       return 100 * this.bulletsHit / this.bulletsFired;
   },
   
   showGameOver: function() {
       Crafty.e('Text2, FollowCamera').move(100, 100).fontSize(72).text('GAME OVER!');
       console.log("Meteors Seen: " + this.meteorsSeen);
       console.log("Bullet Accuracy: " + this.getAccuracy() + "%");       
   }
});