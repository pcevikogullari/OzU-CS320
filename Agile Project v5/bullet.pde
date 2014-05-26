class bullet {

  bullet weapon;
  float increase;
  float damageSize;
  int size;
  int clr;

  bullet() {
  }

  bullet(int wpnTipX, int wpnTipY, float degree, String wpn) {
    if (wpn == "handgun") {
      this.weapon = new handgun(wpnTipX, wpnTipY, degree);
    }
    else if (wpn == "machinegun") {
      this.weapon = new machinegun(wpnTipX, wpnTipY, degree);
    }
    else if (wpn == "bazooka"){
      this.weapon = new bazooka(wpnTipX, wpnTipY, degree);
    }
  }

  public int getDelay() {
    return weapon.getDelay();
  }

  public boolean isValid() {
    return weapon.isValid();
  }

  public void move() {
    weapon.move();
  }

  boolean insideScreen(int x, int y) {
    return x>0 && x<width && y>0 && y<height;
  }

  public int getSize() {
    return weapon.size;
  }
  
  public float getDamageSize(){
    return weapon.damageSize;
  }

  public int getX() {
    return weapon.getX();
  }

  public int getY() {
    return weapon.getY();
  }

  public int getDamage() {
    return weapon.getDamage();
  }
}

