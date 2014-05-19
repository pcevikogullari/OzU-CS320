class Monster extends Creature {
  
  private int leftArmA_X;
  private int leftArmA_Y;
  private int leftArmB_X;
  private int leftArmB_Y;
  private int rightArmA_X;
  private int rightArmA_Y;
  private int rightArmB_X;
  private int rightArmB_Y;

  int[][] startLocations = {{round(random(0, width)), 0} , {round(random(0, width)), height} , {0, round(random(0, height))} , {width, round(random(0, height))}};
  float walkDegree;

  Monster(int type) {
    //attributes
    if (type == -1) { // filler
      size = 0;
      speed = 0;
      x = -100;
      y = -100;
      monsterType = -1;
    }
    else if (type == 0) {
      size = 30;
      takesDamage = 10;
      damageRate = 10;
      score = 5;
      health = 100;
      speed = 1;
      regularSpeed = 1;
      r = 255;
      g = 0;
      b = 0;
      border = 5;
      borderColor = 0;
      monsterType = 0;
      //random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
    else if (type == 1) {
      size = 50;
      takesDamage = 5;
      damageRate = 30;
      score = 10;
      health = 100;
      speed = 1;
      regularSpeed = 1;
      r = 132;
      g = 34;
      b = 168;
      border = 7;
      borderColor = 0;
      monsterType = 1;
      // random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
    else if (type == 2) {
      size = 50;
      takesDamage = 3;
      damageRate = 40;
      score = 15;
      health = 100;
      speed = 1.2;
      regularSpeed = 1;
      r = 245;
      g = 237;
      b = 2;
      border = 10;
      borderColor = 0;
      monsterType = 2;
      // random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
    else if (type == 3) {
      size = 15;
      takesDamage = 10;
      damageRate = 30;
      score = 20;
      health = 100;
      speed = 2.2;
      regularSpeed = 2;
      r = 50;
      g = 170;
      b = 50;
      border = 2;
      borderColor = 0;
      monsterType = 3;
      // random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
    else if (type == 4) {
      size = 100;
      takesDamage = 1;
      damageRate = 100;
      score = 25;
      health = 100;
      speed = 0.2;
      regularSpeed = 0.5;
      r = 0;
      g = 0;
      b = 0;
      border = 2;
      borderColor = 40;
      monsterType = 4;
      // random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
     else if (type == 5) {
      size = 30;
      takesDamage = 8;
      damageRate = 100;
      score = 30;
      health = 100;
      speed = 1.0;
      regularSpeed = 1;
      r = 65;
      g = 12;
      b = 156;
      border = 2;
      borderColor = 40;
      monsterType = 5;
      // random
      int indexRandom = round(random(0, 3));
      x = startLocations[indexRandom][0];
      y = startLocations[indexRandom][1];
    }
  }

  void play(float shooterX, float shooterY) {
    drawMonster();
    drawHealthBar();
    walk(shooterX, shooterY);
  }

  void walk(float shooterX, float shooterY) {
    float dX = shooterX - x;
    float dY = shooterY - y;
    walkDegree = atan2(dY, dX);
    x = x + (speed * cos(walkDegree));
    y = y + (speed * sin(walkDegree));
  }

  void drawMonster() {
    drawBody();
    drawArms();
  }

  void drawArms() {
    float dgrA = 5.6;
    float dgrB = 5.8;
    int armSize = size/2;
    leftArmA_X = round(x + (armSize * cos(walkDegree-dgrA)));
    leftArmA_Y = round(y + (armSize * sin(walkDegree-dgrA)));
    leftArmB_X = round(x + (armSize*2 * cos(walkDegree-dgrB)));
    leftArmB_Y = round(y + (armSize*2 * sin(walkDegree-dgrB)));
    rightArmA_X = round(x + (armSize * cos(walkDegree+dgrA)));
    rightArmA_Y = round(y + (armSize * sin(walkDegree+dgrA)));
    rightArmB_X = round(x + (armSize*2 * cos(walkDegree+dgrB)));
    rightArmB_Y = round(y + (armSize*2 * sin(walkDegree+dgrB)));
    stroke(0, 0, 0);
    strokeWeight(5);
    strokeCap(ROUND);
    line(leftArmA_X, leftArmA_Y, leftArmB_X, leftArmB_Y);
    line(rightArmA_X, rightArmA_Y, rightArmB_X, rightArmB_Y);
    noFill();
    noStroke();
  }
  
  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public int getSize() {
    return size;
  }

  public int getScore() {
    return score;
  }
}

