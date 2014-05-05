// move
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

class Creature {

  int monsterType;
  int size;
  int maxHealth = 100;
  int health = 100;
  int damageRate;
  int score;
  float speed;
  float regularSpeed;
  int r, g, b;
  int takesDamage;
  int border, borderColor;
  public float x = width/2;
  public float y = height/2;

  Creature() {
  }

  void play() {
    shooter.play();
  }
  void play(float shooterX, float shooterY) {
    shooter.play(shooterX, shooterY);
  }

  void fire() {
    shooter.fire();
  }

  public int getSize() {
    return size;
  }
  
  public int getType(){
    return monsterType;
  }

  public int getDamageRate() {
    return damageRate;
  }

  public int getTakesDamage() {
    return takesDamage;
  }

  public void damage(int damage) {
    health -= damage;
  }

  public boolean isAlive() {
    return health > 0;
  }

  void drawHealthBar() {
    fill(0, 255, 0);
    rect(x-(maxHealth/4), y-size, (health/2), 2);
    fill(255, 0, 0);
    rect(x-25+(health/2), y-size, 50-(health/2), 2);
    noFill();
  }

  void drawBody() {
      stroke(0);
      strokeWeight(border);
      fill(r, g, b);
      smooth();
      ellipseMode(CENTER);
      ellipse(x, y, size, size);
      noStroke();
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void setX(int x) {
    this.x = x;
  }

  public void setY(int y) {
    this.y = y;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
  }

  public void setHealth(int health) {
    this.health = health;
  }

  public float getRegularSpeed() {
    return regularSpeed;
  }

  public void setColor(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

