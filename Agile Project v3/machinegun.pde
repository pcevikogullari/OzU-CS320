class machinegun extends bullet {
  // Attributes
  String name;
  int delay;
  int damage;
  float speed;
  
  int bulletX;
  int bulletY;
  int wpnTipX;
  int wpnTipY;
  float degree;

  machinegun(int wpnTipX, int wpnTipY, float degree) {
    this.wpnTipX = wpnTipX;
    this.wpnTipY = wpnTipY;
    this.degree = degree;
    bulletX = wpnTipX;
    bulletY = wpnTipY;
    name = "machinegun";
    delay = 50;
    damage = 8;
    size = 3;
    damageSize = 3;
    speed = 2;
    clr = color(0,0,0);
  }

  public String name() {
    return name;
  }

  public int getDelay() {
    return delay;
  }

  public void move() {
    increase += speed;
    bulletX = round(bulletX + (increase * cos(degree)));
    bulletY = round(bulletY + (increase * sin(degree)));
    drawBullet();
  }

  void drawBullet() {
    fill(clr);
    ellipse(bulletX, bulletY, size, size);
    noFill();
  }

  public boolean isValid() {
    return insideScreen(bulletX, bulletY);
  }
  
  public int getX(){
    return bulletX;
  }
  
  public int getY(){
    return bulletY;
  }
  
  public int getDamage(){
    return damage;
  }
}

