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
    walk();
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

