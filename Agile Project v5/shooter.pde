ArrayList<bullet> bullets = new ArrayList<bullet>();
long lastTime = 0;
boolean shot = false;
String currentWeapon = "handgun";

class Shooter extends Creature {

  // shooter
  private int maxHealth = 100;
  private int health = 100;
  // weapon
  private int wpnTipX;
  private int wpnTipY;
  private int weaponLength = 35;
  private float degree;
  // fire
  private boolean shot = false;

  Shooter() {
    size = 50;
    damageRate = 100;
    speed = 2;
    regularSpeed = 2;
    border = 0;
    r=0;
    b=0;
    g=0;
  }

  public void play() {
    drawBody();
    drawWeapon();
    drawHealthBar();
    shootBullets();
    walk();
    if (mousePressed) {
      fire();
    }
  }


  void drawWeapon() {
    float dX = mouseX - x;
    float dY = mouseY - y;

    degree = atan2(dY, dX);
    wpnTipX = round(x + (weaponLength * cos(degree)));
    wpnTipY = round(y + (weaponLength * sin(degree)));

    stroke(0, 0, 0);
    strokeWeight(5);
    strokeCap(ROUND);
    line(x, y, wpnTipX, wpnTipY);
    noFill();
    noStroke();
  }

  void shootBullets() {
    for (int i = 0; i < bullets.size(); i++) {
      if (bullets.get(i).isValid()) {
        bullets.get(i).move();
      }
      else {
        bullets.remove(i);
      }
    }
    if (!mousePressed) {
      lastTime = 0;
    }
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

  void fire() {
    bullet blt = new bullet(wpnTipX, wpnTipY, degree, currentWeapon);
    if ((millis() - lastTime) > blt.getDelay()) {
      bullets.add(blt);
      lastTime = millis();
    }
  }

  public ArrayList<bullet> getBullets() {
    return bullets;
  }

  void walk() {
    if (up) {
      y-=speed;
    }
    if (down) {
      y+=speed;
    }
    if (left) {
      x-=speed;
    }
    if (right) {
      x+=speed;
    }
  }
}

