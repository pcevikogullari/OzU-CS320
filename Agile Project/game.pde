int gameMode = 0;
int score = 0;
int level = 1;
Creature shooter;

class Game {
  Game() {
    shooter = new Shooter();
  }

  void play() {
    background(255, 255, 255);

    if (gameMode == 0) { // start menu
      startScreen();
    }
    else if (gameMode == 1) { // game play
      shooter.play();
      gamePlay();
    }
    else if (gameMode == 2) { // level completed
      leveCompleted();
    }
    else if (gameMode == 3) { // store
    }
    else if (gameMode == 4) {
      death();
    }
  }

  void startScreen() {
    textAlign(CENTER);
    fill(0);
    text("click to start", width/2, height/2);
    noFill();
    if (mousePressed) {
      gameMode = 1;
    }
  }

  void leveCompleted() {
    textAlign(CENTER);
    fill(0);
    text("level "+level+" completed. press 'n' for next level , 's' for store", width/2, height/2);
    noFill();
    if (keyPressed && (key=='n' || key=='n')) {
      level += 1;
      gameMode = 1;
      shooter.setHealth(100);
      shooter.setX(width/2);
      shooter.setY(height/2);
    }
    else if (keyPressed && (key=='s' || key=='S')) {
    }
  }

  void store() {
  }

  void gamePlay() {
  }

  void death() {
    textAlign(CENTER);
    fill(0);
    text("you are dead. your score is "+score, width/2, height/2);
    noFill();
    if (keyPressed && (key=='r' || key=='R')) {
      restart();
      gameMode = 1;
    }
  }

  void restart() {
    shooter.setHealth(100);
    shooter.setX(width/2);
    shooter.setY(height/2);
    shooter.maxHealth = 100;
  }

}
