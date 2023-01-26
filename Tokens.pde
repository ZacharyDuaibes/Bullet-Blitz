//Token class//
//Initializing variables in class//
class Token {
  float x,y; // location
  float r; // dimension
 
  Token(float x, float y) {
    this.x = x;
    this.y = y;
    this.r = 20;
  }
 
  void display() {
    ellipse(this.x, this.y, this.r, this.r);
  }
  
  void tokenCollision(){
    for (int i = 0; i < tokens.size(); i++) {
      Token token = tokens.get(i);
      for (int j = 0; j < enemies.size(); j++) {
      Enemy enemy = enemies.get(j);
        float distance = dist(enemy.x, enemy.y, token.x, token.y);
        if (distance < 31) {
          tokens.remove(i);
          i--;
          tokens.add(new Token(random(30,950), random(30, 700)));
        }
        if (checkToken == true){
          enemy.speed += 0.3;
          enemy.originalEnemySpeed += 0.3;
        }
      }
      
      float distance2 = dist(player.x, player.y, token.x, token.y);
      if (distance2 < 32) {
        checkToken = true;
        score += tokenWorth;
        tokens.remove(i);
        i--;
        tokens.add(new Token(random(30,950), random(30, 700)));
      } else {
        checkToken = false;
      }
    }
  }
}
