class Tests {

  Tests() {
  }

  void test() {
    testGame();
    testBullet();
    testCreature();
    testMonsters();
  }

  void testGame() {
    try {
      Game g = new Game();
      println("Game : true");
    }
    catch(Exception e) {
      println("Game : false");
    }
  }

  void testBullet() {
    try {
      bullet b = new bullet();
      println("Bullet : true");
    }
    catch(Exception e) {
      println("Bullet : false");
    }
  }

  void testCreature() {
    try {
      Creature c = new Creature();
      println("Creature : true");
      println("Creature health : "+(c.health==100));
      println("Creature maxhealth : "+(c.maxHealth==100));
    }
    catch(Exception e) {
      println("Creature : false");
    }
  }

  void testMonsters() {
    testMonsterType1();
    testMonsterType2();
    testMonsterType3();
    testMonsterType4();
    testMonsterType5();
    testMonsterType6();
  }
  void testMonsterType1() {
    try {
      Monster m = new Monster(0);
      println("Monster Type 1 : true");
    }
    catch(Exception e) {
      println("Monster Type 1 : false");
    }
  }
  void testMonsterType2() {
    try {
      Monster m = new Monster(1);
      println("Monster Type 2 : true");
    }
    catch(Exception e) {
      println("Monster Type 2 : false");
    }
  }
  void testMonsterType3() {
    try {
      Monster m = new Monster(2);
      println("Monster Type 3 : true");
    }
    catch(Exception e) {
      println("Monster Type 3 : false");
    }
  }
  void testMonsterType4() {
    try {
      Monster m = new Monster(3);
      println("Monster Type 4 : true");
    }
    catch(Exception e) {
      println("Monster Type 4 : false");
    }
  }
  void testMonsterType5() {
    try {
      Monster m = new Monster(4);
      println("Monster Type 5 : true");
    }
    catch(Exception e) {
      println("Monster Type 5 : false");
    }
  }
  void testMonsterType6() {
    try {
      Monster m = new Monster(5);
      println("Monster Type 6 : true");
    }
    catch(Exception e) {
      println("Monster Type 6 : false");
    }
  }
}

