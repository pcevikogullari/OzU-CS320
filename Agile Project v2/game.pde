// level
int gameMode = 0;
int score = 0;
int level = 1;
int monstersKilled = 0;
float newMonsterInterval[] = {
  1000, 2000
};
boolean addMonsters = true;

// variables
Creature shooter;
boolean slowMod = false;
boolean slowModActive = false;
float maxSlowModMana = 100;
float slowModMana = 100;
float slowModIncreaseSpeed = 0.1;
float slowModDecreaseSpeed = 0.2;
float slowModMonsterSpeed = 0.3;
float slowModShooterSpeed = 0.8;
int lastAddTime = 0;
ArrayList<Monster> monsters = new ArrayList<Monster>();

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
      playMonster();
      addMonsters();
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
    addMonsters = true;
    newMonsterInterval[0] = 1000/(level);
    newMonsterInterval[1] = newMonsterInterval[0] * 2;
    if (monstersKilled >= level*10) {
      gameMode = 2;
    }
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
    score = 0;
    level = 1;
    monstersKilled = 0;
    slowMod = false;
    slowModActive = false;
    maxSlowModMana = 100;
    slowModMana = 100;
  }

  void slowMod() {
    drawSlowModBar();
  }
  void drawSlowModBar() {
    fill(25, 137, 179);
    rect(shooter.getX()-(maxSlowModMana/4), shooter.getY()-shooter.getSize()+2, slowModMana/2, 2);
    noFill();
  }
  
  void addMonsters() {
    if ((millis() - lastAddTime) > round(random(newMonsterInterval[0], newMonsterInterval[1])) && addMonsters) {
      for (int i = 0; i < round(random(2)); i++) {
        //if (level < 3) {
        //  monsters.add(new Monster(0));
        //}
        //else {
          monsters.add(new Monster(round(random(0, 5))));
        //}
      }
      lastAddTime = millis();
    }
  }

  void removeMonsters() {
    for (int i = 0; i < monsters.size(); i++) {
      monsters.remove(i);
    }
  }

  void playMonster() {
    for (int i = 0; i < monsters.size(); i++) {
      monsters.get(i).play(shooter.getX(), shooter.getY());
    }
  }

}

void aliveCheck(Monster m, int i) {
  if (m != null && !m.isAlive()) {
    score += m.getScore();
    monstersKilled++;
    monsters.remove(i);
  }
  if (!shooter.isAlive()) {
    gameMode = 4;
  }
}


