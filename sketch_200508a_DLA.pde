// Diffusion Limited Aggregation
final color BACKGROUND = color(0);

int seedx;
int seedy;
Walker walker;

int hit, step;
float r, g, b;

void setup() {
  size(1280, 600);
  background(BACKGROUND);
  
  // Seed position (singular)
  seedx = width/2;
  seedy = height/2;
  
  // Draw seed
  loadPixels();
  //pixels[seedy*width + seedx] = color(255);
  for (int i = 0; i < width; i++)
    pixels[(height - 1)*width + i] = color(255);
  
  updatePixels();
  
  walker = new Walker();
  
  hit = step = 0;
  r = g = b = 255;
}

void draw() {
  // Multiple steps per draw to speed up animation (but slow if too many iterations)
  for (int i = 0; i < 1; i++) {
    walker.spawn();
    
    // Move walker until hit
    loadPixels();
    while (!checkHit(walker)) {
      walker.move();
    }
    
    // Choose color
    hit++;
    if (hit % 10000 == 0) {
      r = random(255) + 1;
      g = random(255) + 1;
      b = random(255) + 1;
      println(hit);
    }
    println(hit);
    
    // Update pixels
    pixels[walker.y * width + walker.x] = color(r, g, b);
    updatePixels();
  }
}

boolean checkHit(Walker walker) {
    boolean hit = false;
    
    //loadPixels();
    if ((walker.x > 0 && pixels[walker.y*width + (walker.x - 1)] != BACKGROUND) ||           // left
        (walker.y > 0 && pixels[(walker.y - 1)*width + walker.x] != BACKGROUND) ||           // top
        (walker.x < (width - 1) && pixels[walker.y*width + (walker.x + 1)] != BACKGROUND) || // right
        (walker.y < (height - 1) && pixels[(walker.y + 1)*width + walker.x] != BACKGROUND))  // left
          hit = true;
          
    return hit;
}

void rainbow() {
  switch (step) {
    case 0: // red
      g--;
      b--;
      if (g == 0)
        step++;
      break;
      
    case 1: // orange
      g += 0.7;
      if (g == 127)
        step++;
      break;
      
    case 2: // yellow
      g += 0.3;
      if (g == 255)
        step++;
      break;
      
    case 3: // green
      r--;
      if (r == 0)
        step++;
      break;
      
    case 4: // blue
      g--;
      b++;
      if (g == 0)
        step++;
      break;
    
    case 5: // indigo
      r += 0.58;
      b -= 1.02;
      if (r > 75 || b < 130)
        step++;
      break;
      
    case 6: // purple
      r += 0.57;
      b += 0.64;
      if (r > 255 || b > 255)
        step++;
      break;
    
    default:
      break;
  }
}
