// level
int gameMode = 0;
int score = 0;
int level = 1;
int monstersKilled = 0;
int monstersKilledTotal = 0;
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
ArrayList<Boom> booms = new ArrayList<Boom>();

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
      printScoreBoard();
      shooter.play();
      playMonster();
      addMonsters();
      slowMod();
      collusionDetector();
      comtrolBooms();
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

  void printScoreBoard() {
    textAlign(RIGHT);
    fill(0);
    text("Kills : "+(monstersKilled+monstersKilledTotal), width-20, 20);
    text("Score : "+score, width-20, 40);
    textAlign(LEFT);
    text("Weapon : "+currentWeapon, 20, 20);
  }

  void leveCompleted() {
    addMonsters = false;
    removeMonsters();
    removeBullets();
    textAlign(CENTER);
    fill(0);
    text("level "+level+" completed. press 'n' for next level", width/2, height/2);
    noFill();
    if (keyPressed && (key=='n' || key=='N')) {
      monstersKilledTotal += monstersKilled; 
      monstersKilled = 0;
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
    addMonsters = false;
    removeMonsters();
    removeBullets();
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
    monstersKilledTotal = 0;
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

  void removeBullets() {
    for (int i = 0; i < shooter.getBullets().size(); i++) {
      shooter.getBullets().remove(i);
    }
  }

  void collusionDetector() {

    for (int i = 0; i < monsters.size(); i++) {
      Monster m1 = monsters.get(i);
      float m1x = m1.getX();
      float m1y = m1.getY();
      // monster - shooter collides
      if (dist(m1x, m1y, shooter.getX(), shooter.getY()) <= m1.getSize()/2 + shooter.getSize()/2) {
        shooter.damage(m1.getDamageRate());
        m1.damage(shooter.getDamageRate());
        aliveCheck(m1, i);
      }

      for (int x = 0; x < bullets.size(); x++) {
        bullet blt = bullets.get(x);
        int bulletX = blt.getX();
        int bulletY = blt.getY();
        float bulletSize = blt.getSize()/2;
        // monster - bullets collide
        if (dist(m1x, m1y, bulletX, bulletY) <= (m1.getSize()/2 + blt.getDamageSize()/2)) {
          checkEffectZone(bulletX, bulletY, blt.getDamageSize(), blt.getDamage(), i);
          bullets.remove(x);
        }
      }

      for (int j = 0; j < monsters.size(); j++) {
        Monster m2 = monsters.get(j);
        float m2x = m2.getX();
        float m2y = m2.getY();
        // monster - monster collides
        if (dist(m1x, m1y, m2x, m2y) <= (m1.getSize()/2 + m2.getSize()/2)) {
          monstersCollided(m1, m2);
        }
      }
    }
  }

  void checkEffectZone(int bulletX, int bulletY, float damageSize, int damage, int monsterIndex) {
    float bulletSize = damageSize / 2;
    booms.add(new Boom(bulletX, bulletY, damageSize, currentWeapon));
    for (int i = 0; i < monsters.size(); i++) {
      Monster m = monsters.get(i);
      float mx = m.getX();
      float my = m.getY();
      if (dist(mx, my, bulletX, bulletY) <= (m.getSize()/2 + bulletSize)) {
        m.damage(damage*m.getTakesDamage());
        aliveCheck(m, i);
      }
    }
  }
}

void comtrolBooms() {
  for (int i = 0; i < booms.size(); i++) {
    Boom boom = booms.get(i);
    if (boom.isActive()) {
      boom.play();
    }
    else {
      booms.remove(i);
    }
  }
}

void monstersCollided(Monster m1, Monster m2) {
  float dX = m1.getX() - m2.getX();
  float dY = m1.getY() - m2.getY();
  float degree = atan2(dY, dX);

  m1.setX(m1.getX() + (1 * cos(degree)));
  m1.setY(m1.getY() + (1 * sin(degree)));
  m2.setX(m2.getX() - (1 * cos(degree)));
  m2.setY(m2.getY() - (1 * sin(degree)));
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

