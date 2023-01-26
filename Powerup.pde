//Powerup class//
//Initializing variables in class//
//Pickking a random color from a color list and assigning it to the powerup - each color has a unique quality//
//Powerup collision - checks the distance between player and the power-up - distance is less than or equal to 31, it removes the power-up from the array//
class Powerup {
  float x,y; // location
  float r; // dimension
  color c;
 
  Powerup(float x, float y) {
    this.x = x;
    this.y = y;
    this.r = 20;
    this.c = colors[(int)random(colors.length)];
  }
 
  void display() {
    fill(this.c);
    ellipse(this.x, this.y, this.r, this.r);
  }
  
  void powerupCollision(){
    for (int i = 0; i < powerups.size(); i++) {
      Powerup powerup = powerups.get(i);
      float distance = dist(player.x, player.y, powerup.x, powerup.y);
      if (distance <= 31) {
        powerups.remove(i);
        i--;
        int index = -1;
        for (int j = 0; j < colors.length; j++) {
          if (colors[j] == this.c) {
            index = j;
          }
        }
        if (index == 0){
          powerupTimer = 5;
          for (Enemy enemy:enemies){
            enemy.speed = 0;
          }
          if (powerupTimer <= 0){
            powerupTimer = 0;
            for (Enemy enemy:enemies){
              enemy.speed = originalEnemySpeed;
            }
          }
        }
        if (index == 1){
          powerupTimer2 = 5;
          tokenWorth = 2;
        }
      }
    }
  }
}
