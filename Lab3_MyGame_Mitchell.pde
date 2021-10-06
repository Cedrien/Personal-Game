//creates template for objects of type obstacle 2
class obstacle2 {
  float xpos;
  float ypos;
  float h;
  float w;
  //constructor to initialize values
  obstacle2() {
    h= random(0, 350);
    w=30;
    rectMode(CENTER);
    xpos = width;
    ypos = 0;
  }
  float hit(){
  return ypos+h/2+10;
  }
  void move() {
    xpos-=5;
  }
  void display() {
    rect(xpos, ypos, w, h);
    //checks if player has collided with obstacle
  }
  boolean collision() {
    if (mouseY<ypos+h/2+10&&x>xpos-w/2&&x<xpos+w/2) {
      return true;
    }
    return false;
  }
  //check if object is less than 0 so it can remove it from the listarray
  boolean dead() {
    if (xpos<0) {
      return true;
    }
    return false;
  }
}
class circ {
  float x;
  float y;
  float r;
  float g;
  float b;
  float s;
  circ() {
    x= random(0, width);
    y= random(0, height);
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    s= random(10, 40);
  }
  void display() {
    fill(r, g, b);
    ellipse(x, y, s, s);
  }
}
ArrayList<obstacle2> o2;
ArrayList<circ> c;
int score =0;
void setup() {
  size(300, 300);
  o2 = new ArrayList<obstacle2>();
  c = new ArrayList<circ>();
}
int s= 20;
float x=30;
float ph=300;
boolean red = false;
int fr =40;
float speed = .2;
int b=255;
int i = 0;
int h;
int w;
int hpos;
int hpos2;
int hpos3;
boolean start=false;
void draw() {
  background(0);
  if (start==false) {
    text("Try to avoid obstacles for as long as possible", 10, 20);
    text(" as floor rises, use mouse to move player", 10, 30);
    rectMode(CENTER);
    hpos2 = 95;
    h=20;
    w=50;
    rect(width/2+10, hpos2, w, h);
    hpos3=195;
    rect(width/2+10, hpos3, w, h);
    fill(0);
    hpos =100;
    text("Start", width/2, hpos);
    hpos = 200;
    text("Quit", width/2, hpos);
    if (mouseY>hpos2-h/2&&mouseY<hpos2+h/2&&mouseX>width/2-w/2&&mouseX<width/2+w/2&&mousePressed) {
      start=true;
    }
    if (mouseY>hpos3-h/2&&mouseY<hpos3+h/2&&mouseX>width/2-w/2&&mouseX<width/2+w/2&&mousePressed) {
      exit();
    }
    fill(255);
  }

  if (start==true) {
    //adds circle to background every time score goes up
     for (circ cs : c) {
      cs.display();
    }
    fill(b);
    text("Score:"+score, 20, 20);
    fill(255);
    x-=5;
      for(obstacle2 o3:o2){
    if(o3.hit()>=ph-100||ph>height)
    {
      speed*=-1;
    }
    if(ph>height){
    ph=300;
    }
    }
    ph-=speed;
    //rectangle that moves up to kill the player
    rect(0, ph, width*2, 20);
    if (mouseY>=ph-20) {
      {
        c.add(new circ());
        x=width;
        ph=300;
        score++;
      }
    }
    if (x<=30) {
      x=30;
    }
    //increasing difficulty
    if (score>=5) {
      speed=.3;
    }
    if (score>=10) {
      speed=.7;
    }
    //sets the obstacles on an interval
    if (frameCount%fr==0) {
      o2.add(new obstacle2());
    }
    for (obstacle2 course2 : o2) {
      course2.display();
      course2.move();
    }
    for (obstacle2 course : o2) {
      if (course.collision()==true) {
        x=width;
        ph=300;
        score++;
        c.add(new circ());
      }
      for (obstacle2 course3 : o2) {
        if (course3.dead()==true) {
          o2.remove(course3);
        }
      }
      //creates the player
      fill(0, 0, 255);
      rect(x, mouseY, s, s);
      fill(255);
    }
  }
}
