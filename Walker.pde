class Walker {
  int x;
  int y;
  
  Walker() {
    spawn();
  }
  
  void spawn() {
    x = (int) random(width);
    y = (int) random(height);
  }
  
  void move() {    
    switch ((int) random(4)) {
    case 0:
      if (x > 0)
        x--;
      break;
    case 1:
      if (y > 0)
        y--;
      break;
    case 2:
      if (x < width - 1)
        x++;
      break;
    case 3:
      if (y < height - 1)
        y++;
      break;
    }
  }
}
