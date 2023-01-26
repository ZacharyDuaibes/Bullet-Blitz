//Importing background music//
import processing.sound.*;
SoundFile music;

//Calling all classes//
Player player;

Ball ball;

Enemy enemy;

Token token;

Powerup powerup;

//Stores all images//
PImage map;
PImage mainMenuImg;
PImage instructionsImg;
PImage backtoMenu;
PImage backtoMenu2;
PImage backtoMenu3;
PImage highScores;
PImage leaderBoard;
PImage Tokens;
PImage scoreToken;
PImage scoreToken1;
PImage timer;
PImage upgradeImg;
PImage speedIncreaseImg;
PImage magIncrease;
PImage reloadImg;
PImage dmgIncrease;
PImage pauseImg;
PImage gotoMenu;
PImage enemyImg;
PImage enemyImg1;
PImage enemyImg2;
PImage gameOver;
PImage gameOverImg;
PImage crabTokens;
PImage crabTokens2;
PImage winner;

//Creating lists for player shots, enemies, tokens, powerups, and colors for the powerups//
ArrayList<Ball> shots = new ArrayList<Ball>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
//ArrayList<Enemy> bullets = new ArrayList<Enemy>();
ArrayList<Token> tokens = new ArrayList<Token>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
color[] colors = {color(69, 168, 252), color(166, 69, 252)};

//Creating global int/string/float/boolean variables for player score, bullets, upgarde, highscores and dimensions//
int score = 0;
int tokenWorth = 1;
int addShots = 0;
int lastPowerupDisplay = -1;
int totalShots = 20 + addShots;
int shotCounter = 0;
int firedShots = 20;
int poweruptimerX = 901;
int poweruptimerY = 163;
int scoreX = 920;
int scoreY = 73;
int top1Score = 25;
int top2Score = 15;
int top3Score = 10;
int sidebarWidth = 300;
int sidebarX = 700;
String playerName = " ";
String top1Name = "King Crab";
String top2Name = "Cap'n Crunch";
String top3Name = "Jack Sparrow";
float lastSpeed = 1;
float originalEnemySpeed;
float powerupTimer = 0;
float powerupTimer2 = 0;
float reduceTime = 0;
float reloadTimer = 0 + reduceTime;
boolean checkScore = true;
boolean checkToken = false;
boolean checkPowerup = false;
boolean unlocked = false;
boolean paused = false;
boolean canShoot = true;

//Creating game state,setting it to 1 - game starts in main menu//
int gameState = 1;

//Setting up the initial state of the program//
//Setting the screen size//
//Grabbing the music file and playing it on repeat//
//Loading the images and resizing the to desired diemensions//
void setup() {
  
  size(1000, 750);
  
  music = new SoundFile(this, "mainMenuMusic.mp3");
  music.loop();
  
  map = loadImage("map.png");
  map.resize(1000, 750);
  mainMenuImg = loadImage("mainMenuImg.png");
  mainMenuImg.resize(1000, 750);
  instructionsImg = loadImage("instructionsImg.png");
  instructionsImg.resize(1000, 750);
  backtoMenu = loadImage("backtoMenu.png");
  backtoMenu.resize(100, 75);
  highScores = loadImage("highScores.png");
  highScores.resize(1000, 750);  
  leaderBoard = loadImage("leaderBoard.png");
  leaderBoard.resize(700, 700);
  Tokens = loadImage("scoreDisplay.png");
  Tokens.resize(55, 55);
  scoreToken = loadImage("scoreDisplay.png");
  scoreToken.resize(80, 80);
  scoreToken1 = loadImage("scoreDisplay.png");
  scoreToken1.resize(55, 55);
  timer = loadImage("timerImg.png");
  timer.resize(75, 47);
  upgradeImg = loadImage("upgradeImg.png");
  upgradeImg.resize(100,110);
  speedIncreaseImg = loadImage("SpeedIncrease.png");
  speedIncreaseImg.resize(60, 48);
  magIncrease = loadImage("magIncrease.png");
  magIncrease.resize(60,55);
  reloadImg = loadImage("reloadImg.png");
  reloadImg.resize(65,60);
  dmgIncrease = loadImage("dmgIncrease.png");
  dmgIncrease.resize(75,70);
  pauseImg = loadImage("pauseImg.png");
  pauseImg.resize(115,110);
  gotoMenu = loadImage("gotoMenu.png");
  gotoMenu.resize(400,200);
  enemyImg = loadImage("enemyImg.png");
  enemyImg.resize(100,100);
  enemyImg1 = loadImage("enemyImg.png");
  enemyImg1.resize(90,90);
  enemyImg2 = loadImage("enemyImg.png");
  enemyImg2.resize(70,70);
  gameOver = loadImage("gameOver.png");
  gameOverImg = loadImage("gameOverImg.png");
  gameOverImg.resize(1000,750);
  crabTokens = loadImage("crabTokens.png");
  crabTokens.resize(80,90);
  crabTokens2 = loadImage("crabTokens2.png");
  crabTokens2.resize(70,60);
  backtoMenu2 = loadImage("backtoMenu2.png");
  backtoMenu2.resize(100, 125);
  winner = loadImage("winner.jpg");
  winner.resize(1000, 750);
  backtoMenu3 = loadImage("backtoMenu.png");
  backtoMenu3.resize(100, 75);
  
}


//Setup the state of the game depending on what value gameState is set to//
void draw() {
  
  if (gameState == 1){
    mainMenu();
  }
  else if (gameState == 2){
    inGame();
  }
  else if (gameState == 3){
    instructions();
  }
  else if (gameState == 4){
    highScores();
  }
  else if (gameState == 5){
    gameOver();
  }
  else if (gameState == 6){
    winner();
  }
}


//Function for updating the highscores order dpending on players score//
void scoreCheck(){
  if (score > top3Score && score < top2Score){
    top3Score = score;
    top3Name = playerName;
  } else if (score > top2Score && score < top1Score){
    top3Score = top2Score;
    top3Name = top2Name;
    top2Score = score;
    top2Name = playerName;
  } else if (score > top1Score){
    top3Score = top2Score;
    top3Name = top2Name;
    top2Score = top1Score;
    top2Name = top1Name;
    top1Score = score;
    top1Name = playerName;
  }
}

//Displaying main menu titles and changing their display when the mouse hovers over them//
void mainMenu(){
  stroke(1);
  image(mainMenuImg, 0, 0);
  fill(0);
  textSize(100);
  text("ɮʊʟʟɛ₮", 345, 130);
  text("ɮʟɨ₮ʐ", 418, 200);
  textSize(50);
  fill(255);
  
  if (mouseX > 360 && mouseX < 615 && mouseY > 360 && mouseY < 417) {
    fill(131,131,131, 60);
  }
  rect(360, 360, 255, 57);
  fill(255);
  if (mouseX > 345 && mouseX < 630 && mouseY > 452 && mouseY < 510) {
      fill(131,131,131, 60);
  }
  rect(345, 450, 285, 57);
  fill(255);
  if (mouseX > 360 && mouseX < 625 && mouseY > 544 && mouseY < 600) {
      fill(131,131,131, 60);
  }
  rect(360, 540, 265, 57);
  fill(255);
  if (mouseX > 390 && mouseX < 633 && mouseY > 611 && mouseY < 690) {
    fill(131,131,131, 60);
  }
  rect(385, 630, 220, 57);
  
  fill(0);
  text("ѕтαят gαмє", 370, 400);
  text("ιηѕтяυ¢тισηѕ", 355, 490);
  text("нιgн ѕ¢σяєѕ", 370, 580);
  text("єχιт gαмє", 395, 670);
}

//Display the instructions and how to play//
void instructions(){
  image(instructionsImg, 0, 0);
  fill(0);
  textSize(60);
  text("ιηѕтяυ¢тισηѕ", 340, 50);
  text("___________", 340,65);
  text("нσω тσ PʟαY", 345,435);
  text("__________", 345,450);
  textSize(40);
  text("ΛVσιD ѕαηD ¢яιттєяѕ!", 325, 125);
  text("¢σℓℓє¢т тσкєηѕ тσ вυу υρgяα∂єѕ!", 220, 185);
  text("¢σℓℓє¢т ρσωєяυρѕ тσ нєℓρ уσυ!", 235, 245);
  text("¢σℓℓє¢т 50 тσкєηѕ тσ ωιη!", 280, 305);
  text("уσυ σηℓу нανє 1 ℓιƒє ѕσ вє ¢αяєƒυℓ!", 200, 365);
  text("υѕє ω-α-ѕ-∂ тσ мσνє.", 310,505);
  text("υѕє тнє Λяяσω кєуѕ тσ ѕнσσт.", 250,565);
  text("ρяєѕѕ 'ρ' тσ Λ¢¢єѕѕ υρgяα∂єѕ.", 245,625);
  text("ѕΘмє ѕ¢яєєηѕ нΛVє Λη ΛяяΘω, ρяєѕѕ ιт тΘ gΘ тΘ тнє", 70,685);
  text("мєηυ.", 455,730);
  image(backtoMenu, 760, 420);
}

//Dsiplay the pregame auto-set highscores//
void highScores(){
  image(highScores, 0, 0);
  image(leaderBoard, 150, 10);
  image(backtoMenu, 100, 625);
  fill(0);
  textSize(25);
  text(top1Name, 400, 225);
  text(top1Score, 580, 225);
  text(top2Name, 400, 278);
  text(top2Score, 580, 279);
  text(top3Name, 400, 330);
  text(top3Score, 580, 330);
  scoreCheck();
}

//If player loses, game over menu is deisplayed//
//Player inputs their three charcter name so highscore can be updated accordingly// 
void gameOver(){
  image(gameOverImg, 0, 0);
  image(gameOver, 225, 100);
  image(enemyImg,100,600);
  image(enemyImg1,200,650);
  image(enemyImg2,275,600);
  image(crabTokens, 200,590);
  image(crabTokens2, 130,675);
  image(backtoMenu2, 610, 540);
  fill(0);
  textSize(30);
  text("ηΛʍє (3): " + playerName, 400,360);
}

void winner(){
  image(winner, 0, 0);
  textSize(60);
  fill(0);
  text(playerName, 350,360);
  text(score, 600, 360);
  image(backtoMenu3, 450,400);
}

//Player can pause (p) midgame to access the upgrades//
//Looping through eney, powerup, token and bullet list to display them//
//Checking score too determine if enemy should spawn in//
//Cheking if plaer can shoot or is reloading//
void inGame(){
  if (paused) {
      
    fill(255);
    rect(sidebarX, 0, sidebarWidth, 680);
    fill(255,255,255, 1);
    noStroke();
    rect(0, 0, 700, 750);
    rect(700, 680, 300, 70);
    image(pauseImg, 400, 290);
      
    // Draw the sidebar text
    fill(0);
    //textAlign(CENTER);
    textSize(30);
    text("Upgrades", 800, 50);
    image(upgradeImg, 735, -10);
    image(upgradeImg, 885, -10);
      
    // Draw a button
    fill(0);
    textSize(20);
    text("Speed Increase", 835, 110);
    textSize(25);
    text("3", 840, 140);
    image(scoreToken1, 850, 108);
    image(speedIncreaseImg, 745, 94);
    text(nf(player.SPEED, 0, 0), 767, 170);
    if (player.SPEED >= 10){
      text("MAX", 900, 140);
    }
    
    // Draw a button
    fill(0);
    textSize(20);
    text("Magazine Increase", 820, 210);
    textSize(25);
    text("6", 840, 240);
    image(scoreToken1, 850, 208);
    image(magIncrease, 745, 190);
    text(20 + addShots, 763, 270);
    if (20 + addShots >= 35){
      text("MAX", 900, 240);
    }
    
    fill(0);
    textSize(20);
    text("Reload Time", 840, 315);
    textSize(25);
    text("9", 840, 345);
    image(scoreToken1, 850, 313);
    image(reloadImg, 745, 290);
    text(nf(5 - reduceTime, 0, 1), 763, 375);
    if (5 - reduceTime <= 1.5){
      text("MAX", 900, 345);
    }
      
    fill(0);
    textSize(20);
    text("Damage Increase", 820, 420);
    textSize(25);
    text("12", 835, 450);
    image(scoreToken1, 855, 418);
    image(dmgIncrease, 745, 385);
    text(nf(player.bulletDamage, 0, 2), 760, 480);
    if (player.bulletDamage == 1.5){
      text("MAX", 900, 450);
    }
    
    fill(0);
    textSize(50);
    text(score, 865, 550);
    image(scoreToken, 790, 500);
    image(gotoMenu, 560, 470);
    
    return;
    }
    
    background(0);
    
    fill(250,250,250);
    rect(10,10,980,730);
  
    image(map, 0, 0);
    image(scoreToken, 842, 23);
    fill(0);
    textSize(45);
    text(score, scoreX ,scoreY);
    
    fill(34,221,47);
    stroke(0);
    strokeWeight(1.5);
    player.display();
    player.move();
    player.windowCollision();
    
    for (int i = 0; i < shots.size(); i++) {
      Ball ball = shots.get(i);
      fill(0);
      ball.displayShots();
      ball.bulletMove();
      ball.bulletCollision();
    }
    
    for (Token token: tokens){
      fill(221,222,49);
      token.display();
      token.tokenCollision();
    }
    
    for (Enemy enemy: enemies){
      lastSpeed = enemy.speed;
      fill(245,12,47);
      enemy.display();
      enemy.followPlayer();
      enemy.enemyPLayerCollision();
      enemy.enemyCollision();
    }
    if (score % 2 != 0){
      checkScore = true;
    }
    if (enemies.size() == 0) {
      enemies.add(new Enemy(0, 0, 40, lastSpeed, player, 3));
    }
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      if (score % 2 == 0 && score != 0 && checkScore == true){
        enemies.add(new Enemy(0, 0, 40, enemy.originalEnemySpeed, player, 3));
        checkScore = false;
      }
    }
    
    if (score % 4 == 0 && score != 0 && score > lastPowerupDisplay && powerupTimer <= 0 && powerupTimer2 <= 0) {
      lastPowerupDisplay = score;
      checkPowerup = true;
      powerups.add(new Powerup(random(30,970), random(30, 720)));
    } else if (lastPowerupDisplay > 0) {
      checkPowerup = true;
    }
    
    for (int i = 0; i < powerups.size(); i++) {
      Powerup powerup = powerups.get(i);
      if (checkPowerup == true){
        powerup.display();
        powerup.powerupCollision();
      }
    }
    //println(mouseX,mouseY);
    if (powerupTimer > 0){
      powerupTimer -= 0.01;
      fill(0);
      text(nf(powerupTimer, 0, 2), poweruptimerX, poweruptimerY);
      image(timer, 842, 115);
      textSize(30);
      fill(255);
      rect(350,0,270,30);
      fill(#40CEFF);
      text("CHILL out for a bit!!", 360, 25);
    }
    if (powerupTimer2 > 0){
      powerupTimer2 -= 0.01;
      fill(0);
      text(nf(powerupTimer2, 0, 2), poweruptimerX, poweruptimerY);
      image(timer, 842, 115);
      textSize(30);
      fill(255);
      rect(400,0,170,30);
      fill(0);
      text("Double up!!", 410, 25);
      if (powerupTimer2 <= 0) {
        tokenWorth = 1;
      }
    }
    if (reloadTimer > 0) {
      reloadTimer -= 0.01;
      textSize(20);
      fill(0);
      text("Reloading...", player.x - 43, player.y + 40);
    }else if (reloadTimer <= 0) {
      canShoot = true;
      textSize(20);
      fill(0);text(firedShots, player.x - 9, player.y + 6);
    }
    if (firedShots == 0) {
      canShoot = false;
      reloadTimer = 5 - reduceTime;
      firedShots = 20 + addShots;
    }
  
    if (score >= 30){
      gameState = 6;
    }
}

//If function is called, resets all variables to their original value// 
void reset(){
  lastSpeed = 1;
  
  checkScore = true;
  checkToken = false;
  tokenWorth = 1;
  
  addShots = 0;
  reloadTimer = 0 + reduceTime;
  reduceTime = 0;
  
  lastPowerupDisplay = -1;
  checkPowerup = false;
  powerupTimer = 0;
  powerupTimer2 = 0;
  unlocked = false;
  
  paused = false;
  sidebarWidth = 300; // Width of the side bar
  sidebarX = 700; // X position of the side bar
  
  poweruptimerX = 907;
  poweruptimerY = 152;
  
  scoreX = 920;
  scoreY = 73;
  
  canShoot = true;
  totalShots = 20 + addShots;
  shotCounter = 0;
  firedShots = 20;
  
  shots.clear();
  enemies.clear();
  tokens.clear();
  powerups.clear();
}

//Main menu: game state changes depending on where user places mouse//
//Calling the reset button when user presses the start game option//
//In game - user presses pause: Dependent where user presses, different upgrades take place//
//Checking if a player ability reaches a certain value = maxed out upgrade//
void mousePressed() {
  if (gameState == 1){
    if (mouseX > 360 && mouseX < 615 && mouseY > 360 && mouseY < 417) {
      reset();
      gameState = 2;
      score = 0;
      playerName = " ";
      player = new Player(600,600,40,5, 0.5);
      enemies.add(new Enemy(0, 0, 40, 1, player, 3));
      tokens.add(new Token(random(30,970), random(30, 720)));
      originalEnemySpeed = enemies.get(0).speed;
      }
    if (mouseX > 345 && mouseX < 630 && mouseY > 452 && mouseY < 510) {
      gameState = 3;
    }
    if (mouseX > 360 && mouseX < 625 && mouseY > 544 && mouseY < 600) {
      gameState = 4;
    }
    if (mouseX > 390 && mouseX < 633 && mouseY > 611 && mouseY < 690) {
      exit();
    }
  }
  
  if (gameState == 6){
    if (mouseX > 454 && mouseX < 545 && mouseY > 409 && mouseY < 469) {
      gameState = 1;
    }
  }
  
  if (paused){
    if (mouseX > 828 && mouseX <875198 && mouseY > 606 && mouseY < 642) {
        gameState = 1;
      }
  }
  
  if (gameState == 3){
    if (mouseX > 776 && mouseX < 855 && mouseY > 428 && mouseY < 491) {
        gameState = 1;
      }
  }
    
  if (gameState == 4){
    if (mouseX > 105 && mouseX < 198 && mouseY > 635 && mouseY < 698) {
        gameState = 1;
      }
  }
  
  if (gameState == 5){
    if (mouseX > 614 && mouseX < 707 && mouseY > 544 && mouseY < 663) {
        gameState = 1;
      }
  }
    
  if (paused) {
    
    if (mouseX > 750 && mouseX < 801 && mouseY > 97 && mouseY < 141) {
      if (score > 3){
        if (player.SPEED >= 10){
          player.SPEED += 0;
        }else{
          player.SPEED += 1;
          score -= 3;
        }
      }
    }
    if (mouseX > 744 && mouseX < 804 && mouseY > 195 && mouseY < 243) {
      if (score > 6){
        if (20 + addShots >= 35){
          totalShots = 40;
          addShots += 0;
        }else{
          addShots += 2;
          score -= 6;
        }
      }
    }

    if (mouseX > 747 && mouseX < 806 && mouseY > 293 && mouseY < 348) {
      if (score > 9){
        if (5 - reduceTime <= 1.5){
          reloadTimer = 1.50;
          reduceTime += 0;
        }else{
          reduceTime += 0.5;
          score -= 9;
        }
      }
    }
    if (mouseX > 750 && mouseX < 801 && mouseY > 402 && mouseY < 433) {
      if (score > 1){
        if (player.bulletDamage == 1.5){
          player.bulletDamage += 0;
        }else{
          player.bulletDamage += 0.25;
          score -= 1;
        }
      }
    }
  }
}

//Player movement when W-A-S-D are pressed//
//Gameover - player enters name//
//If player presses arrow key then a bullet is added to the bullet list//
void keyPressed() {
  if (gameState == 5){
    if (playerName.length() < 4) {
      char letter;
      letter = key;
      playerName += letter;
    }
  }
  if (gameState == 6){
    if (playerName.length() < 4) {
      char letter;
      letter = key;
      playerName += letter;
    }
  }
  if (gameState == 2){
    if (key == 'p') {
      paused = !paused;
    }
    if (key == 'w') {
      player.w = true;  
    }
    if (key == 's') {
      player.s = true;
    }
    if (key == 'a') {
      player.a = true;
    }
    if (key == 'd') {
      player.d = true; 
    }
    if (key == CODED) {
      if (canShoot) {
          if (keyCode == UP) {
            shots.add(new Ball(player.x, player.y, 0, -7));
            shotCounter += 1;
            firedShots -= 1;
          }
          if (keyCode == DOWN) {
            shots.add(new Ball(player.x, player.y, 0, 7));
            shotCounter += 1;
            firedShots -= 1;
          }
          if (keyCode == LEFT) {
            shots.add(new Ball(player.x, player.y, -7, 0));
            shotCounter += 1;
            firedShots -= 1;
          }
          if (keyCode == RIGHT) {
            shots.add(new Ball(player.x, player.y, 7, 0));
            shotCounter += 1;
            firedShots -= 1;
          }
      }
    }
  }
}

//If key is released, thekey is set to false until user presses again//
void keyReleased() {
  if (gameState == 2){
    if (key == 'w') {
      player.w = false;  
    }
    if (key == 's') {
      player.s = false;
    }
    if (key == 'a') {
      player.a = false;
    }
    if (key == 'd') {
      player.d = false; 
    }
  }
}
