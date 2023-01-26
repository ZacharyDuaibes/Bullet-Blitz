//Enemy class//
//Initializing variables in class//
//FUnction to follow the player by calculating the diffrence between the enemy and player position//
//Function for collision with enemies//
//Function to check collison between enemies - iterate through each enemy in the array - checks the distance between enemies
//distance is less than 38, calculates a repulsion vector between the two enemies - applies that vector to the positions of both enemies, causing them to move away from each other//
class Enemy{
  float x;
  float y;
  float r;
  float speed;
  Player player;
  float health;
  float originalEnemySpeed;
  
  Enemy(float x, float y, float r, float speed, Player player, float health){
    this.x = x;
    this.y = y;
    this.r = r;
    this.speed = speed;
    this.originalEnemySpeed = speed;
    this.player = player;
    this.health = health;
  }
  
  void display(){                                                                  
    ellipse(this.x, this.y, this.r, this.r);
  }
  
  void followPlayer(){
    if (powerupTimer <= 0){
      speed = originalEnemySpeed;
      float diffX = player.x - x;
      float diffY = player.y - y;
      float distance = dist(x, y, player.x, player.y);
      x += diffX / distance * speed;
      y += diffY / distance * speed;
    }
  }
  
  void enemyPLayerCollision(){
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      float distance = dist(enemy.x, enemy.y, player.x, player.y);
      if (distance < 38) {
        player.lives -= 1;
        if (player.lives == 0){
          gameState = 5;
        }
      }
    }
  }
  
  void enemyCollision(){
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy1 = enemies.get(i);
      for (int j = i+1; j < enemies.size(); j++) {
        Enemy enemy2 = enemies.get(j);
        float distance = dist(enemy1.x, enemy1.y, enemy2.x, enemy2.y);
        if (distance < 38) {
          PVector repulsion = PVector.sub(new PVector(enemy1.x, enemy1.y), new PVector(enemy2.x, enemy2.y));
          repulsion.normalize();
          repulsion.mult(0.4);
          enemy1.x += repulsion.x;
          enemy1.y += repulsion.y;
          enemy2.x -= repulsion.x;
          enemy2.y -= repulsion.y;
        }
      }
    }
  }
}
