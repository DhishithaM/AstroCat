//Final Prototype by: Dish, Maria, Rachel
//Directions:
//Click mouse to "shoot"
//Move mouse to "move cat charater"
//key press when "game over" to "reset"
//Global Variables
//Images and fonts
//--------Rachel----------//drawing of cat, UFO, gameover
PImage cat; //astroCat image
PImage UFO;//UFO image
PImage GameOver;//gameover image
//--------Dish----------//drawing of comets
PImage comet;  //comet image
//--------Maria----------//drawing of background and point system
PImage bg; // game background
PFont pointsSystem;//font for point system
int points = 0;//points increase when laser hits astroid
PFont typeface1;  //font
//--------Rachel----------//laser variables
boolean shoot = true; //shoot is false
float laserX1 = 0;//lasers X value
float laserY1 = mouseY;//laser Y value
float velocityY1 = 10; //velocity
//--------Dish----------//comet Variables
boolean movedown = true;//moving down
float cometX = random(50, 290);//comet X
float cometY = random(-350, -100);//comet Y
float comet2X = random(310, 500);//comet X
float comet2Y = random(-350, -100);//comet Y
float VelocityC = 5;//comet velocity
int cometSizex = 60; // comet size
int cometSizey = 100; // comet size
//--------Rachel----------//cat variables and UFO
boolean Alive = true;
float catX; //cat x value
float catY; //cat y value
int catSizeX = 90;  //cat size x
int catSizeY = 150;//cat size y
//little UFO
float UFOx = 1000;//UFO x starting value
float UFOy = random(200, 400);//UFO random x value

void setup() {
  size(600, 800); //canvas size
  frameRate(100); //speed
  comet = loadImage("Comet.png"); //comet image
  bg = loadImage("Game Background.jpg"); //background image
  GameOver = loadImage("GameOver.png");
  cat = loadImage("AstroCat.png");  //astro cat image
  pointsSystem = createFont ("manaspc.ttf", 30);//text for font
  UFO = loadImage("UFO.png");
}

void draw () {
  background(bg); //background
  image(UFO, UFOx, UFOy, 150, 150);//background UFO
  textFont (pointsSystem);//font for points system
  fill(255);//color fill to white
  text ("Point:", 15, 60);//game play points indicator text
  text (points, 150, 60);//how many points a player has revived text
  fill(255, 0, 0);//red laser
  rect(laserX1 - 23, laserY1 - 40, 5, 30);//the laser
  image (cat, catX, catY, catSizeX, catSizeY);// the astroCat
  image (comet, cometX, cometY, cometSizex, cometSizey);//comet image
  image (comet, comet2X, comet2Y, cometSizex, cometSizey);//comet image
  //--------Rachel----------//UFO movement and creation
  UFOx = UFOx - 1;//UFO velocity
  if (UFOx < -400) {//If less then -400 resets UFO positons
    UFOx = 1000;//UFOx is at 1000
    UFOy = random(200, 400);//UFO has a random y value
  }
  GameOver();//game over call
  Cat();//cat call
  //--------Rachel----------//laser properties, shooting and resetting
  if ((shoot && laserY1 <= 800)) {//if fire true
    laserY1 = laserY1 - velocityY1;//laser moves up by velocity
  }
  if (laserY1 < 0) {//if lasers y value is less then 0
    laserY1 = laserY1 + 850;//cat resets back to cat
    shoot = false; //fire is false again
  }
  //--------Rachel----------//movedown boolean function creation
  if (movedown == true) {//moves down when true
    cometY = cometY + VelocityC;//comet moves down by velocity
    comet2Y = comet2Y + VelocityC;//comet moves down by velocity
  }
  //--------Dish----------//stopping comet movement when game over
  if (movedown == false) {//comet isnt moving
    cometX = 0;//changes the x to 0
    cometY = 0;//changes the y to 0
    comet2X = 0;//changes the x to 0
    comet2Y = 0;//changes the y to 0
  }
  //--------Dish----------//moving down and resetting comets
  if ((cometY <= 600) || (comet2Y <= 600)) {//less then 600 then true
    movedown = true;// moving down true
  }
  if (cometY > 800) {//greater then resets back at top of screen
    cometX = random(100, 290);//sets comets at random X value
    cometY = random(-350, -100);//sets comet at random y value above screen
    cometY = cometY + VelocityC;//gives the comet a velocity
  }
  if (comet2Y > 800) {//greater then resets back at top of screen
    comet2X = random(310, 500);//sets comets at random X value
    comet2Y = random(-350, -100);//sets comet at random y value above screen
    comet2Y = comet2Y + VelocityC;//gives the comet a velocity
  }
  //the comet is moving down
  if (movedown) {
    //--------Rachel----------//point system
    //--------Maria----------//comet and laser collison & points
    //--------Dish----------//comet moveing down and x and y
    //make shoot false when collided
    if (Collide(laserX1 - 23, laserY1, 20,
      cometX, cometY, cometSizex, cometSizey)) {//if parameters are met -
      cometX = random(100, 290);//sets comets at random X value
      cometY = random(-350, -100); //sets comet at random y value above screen
      cometY = cometY + VelocityC;//gives the comet a velocity
      laserY1 = laserY1 + 650;//makes laser move off screen
      shoot = false;//shoot turnes to false
      points++;  //if laser hits comet 1 more point
    }
  }
  //--------Rachel----------//point system
  //--------Maria----------//comet and laser collison & points
  //--------Dish----------//comet moveing down and x and y
  //make shoot false when collided
  if (Collide(laserX1 - 23, laserY1, 20,
    comet2X, comet2Y, cometSizex, cometSizey)) {//if parameters are met -
    comet2X = random(310, 500);//sets comets at random X value
    comet2Y = random(-350, -100); //sets comet at random y value above screen
    comet2Y = comet2Y + VelocityC;//gives the comet a velocity
    laserY1 = laserY1 + 850;//makes laser move off screen
    shoot = false;//shoot turnes to false
    points++;  //if laser hits comet 1 more point
  }
}
//--------Rachel----------//cat life
void Cat() {//cat's lives
  if (Alive == true) {//when the cat is alive-
    catX = mouseX - 45;//the cat follows the mouseX
    catY = mouseY - 75;//the cat follows the mouseX
  } else {
    catX = 0;//resets cat at 0x if dies
    catY = 0;//resets cat at 0y if dies
  }
}
//--------Rachel----------//Game over function
//--------Maria----------//Cat and comet collision & points reset
//--------Dish----------//text and Movedown
void GameOver() {
  if (Collide(cometX-70, cometY-50, 100, catX, catY, catSizeX-90, catSizeY-150)||
    Collide(comet2X-70, comet2Y-50, 100, catX, catY, catSizeX-90, catSizeY-150)) {//if parameters are met -
    background(GameOver);//you lose screen background
    fill(255);//text fill is white
    text ("Point:", 70, 350);//your points text
    text (points, 70, 400);//how many points you revived that round
    text ("Hit Space", 70, 550);//instructions to tap space to start game
    shoot = false;//shoot is no longer avalable
    movedown = false;//astroids stop moving
    Alive = false;//cat dies :(
    //--------Rachel----------//reset game key pressed
    if (keyPressed == true) {
      cometX = random(100, 290);//resets comet x value
      cometY = random(-350, -100);//resets comet y value
      comet2X = random(310, 500);//resets comet x value
      comet2Y = random(-350, -100);//resets comet y value
      laserY1 = laserY1 + 850;//restes laser y value
      Alive = true;//makes cat alive again
      movedown = true;//astroids move again
      points = 0;//points change back to 0
    }
  }
}
//--------Exercise 7----------//collison function from block breaker game
boolean Collide(float proX, float proY, float
  proSize, float impX, float impY, float impWidth,
  float impHeight) {//parameters collision
  float paddleMaxX = impX + impWidth;//impMaxX is max X value for colliding
  if (proX < paddleMaxX) {//if true will collide
    float ballMaxX = proX + proSize;//the x value of the ball for colliding
    if (impX < ballMaxX) {//if true will collide
      float paddleMaxY = impY + impHeight;//impMaxY is max y value for colliding
      if (proY < paddleMaxY) {//if true will collide
        return (impY < (proY + proSize));//resturn for projectile and imactioned
      }
    }
  }
  return false;//stops above from running if not activated
}
//--------Rachel----------//laser code key pressed function
void mousePressed() {
  if (shoot == false) {//shoot only when shoot = false
    shoot = true;//to shoot the laser
    laserX1 = mouseX;//shoots at x
    laserY1 = mouseY;//shoots at y
  }
}
