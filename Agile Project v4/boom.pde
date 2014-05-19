class Boom {
  int boomX, boomY;
  float boomSize;
  float boomSizeDynamic = 0;
  String weapon;
  boolean boomActive = true;
  long lastTime;
  long boomRefresh;

  Boom(int x, int y, float boomSize, String weapon) {
    this.boomX = x;
    this.boomY = y;
    this.boomSize = boomSize;
    this.weapon = weapon;
    lastTime = millis();
    boomRefresh = millis();
    play();
  }

  void play() {
    if (boomActive) {
      if (millis() - lastTime <= 500) {
        if (boomSizeDynamic <= boomSize) {
          boomSizeDynamic+=80;
        }
        if (boomSizeDynamic > boomSize){
          boomSizeDynamic = boomSize;
        }
      }
      else {
        if (boomSizeDynamic > 0) {
          boomSizeDynamic -= 100;
        }
        else if (boomSizeDynamic < 0) {
          boomSizeDynamic = 0;
        }
        else {
          boomActive = false;
        }
      }
    }

    fill(245, 245, 60, 30);
    ellipse(boomX, boomY, boomSizeDynamic, boomSizeDynamic);
    noFill();
  }

  boolean isActive() {
    return boomActive;
  }
}

