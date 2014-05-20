Game gamePlay;
Tests tests;

void setup() {
  //size(displayWidth, displayHeight, P3D);
  size(500, 500, P3D);
  gamePlay = new Game();
  tests = new Tests();
}

void draw() {
  gamePlay.play();
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    up = true;
  }
  if (key == 's' || key == 'S') {
    down = true;
  }
  if (key == 'a' || key == 'A') {
    left = true;
  }
  if (key == 'd' || key == 'D') {
    right = true;
  }
  if (key == ' ') {
    slowMod = true;
  }
  if (key == '1') {
    currentWeapon = "handgun";
  }
  if (key == '2') {
    currentWeapon = "machinegun";
  }
  if (key == '3') {
    currentWeapon = "bazooka";
  }
  // runs test cases
  if (key == 't') {
    tests.test();
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    up = false;
  }
  if (key == 's' || key == 'S') {
    down = false;
  }
  if (key == 'a' || key == 'A') {
    left = false;
  }
  if (key == 'd' || key == 'D') {
    right = false;
  }
  if (key == ' ') {
    slowMod = false;
  }
}

