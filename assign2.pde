  PImage bgImg;
  PImage soilImg;
  float boarder;//boarder
  float x;
  float y;
  int block = 80;
  
  PImage lifeOneImg;
  PImage lifeTwoImg;  
  PImage lifeThreeImg;
  
  PImage cabbageImg;
  float cabbageRandomX;
  float cabbageRandomY;
  float cabfinalX = cabbageRandomX*block;
  float cabfinalY = 2*block+cabbageRandomY*block;
  
  PImage restartHoveredImg;
  PImage startHoveredImg;
  PImage restartNormalImg;
  PImage startNormalImg;
  PImage gameoverImg;
  int button_W = 144;
  int button_H = 60;
  int buttonX = 248;
  int buttonY = 360;
 
  PImage titleImg;//pic
  
  PImage groundhogImg;
  float groundhogX = 4*block;
  float groundhogY = block;  
  float groundhogXMove=0;
  float groundhogYMove=0; 
  float grfinalX = groundhogX+groundhogXMove;
  float grfinalY = groundhogY+groundhogYMove;
  PImage downImg;
  PImage rightImg;
  PImage leftImg;
  float groundhogSpeed = 0.25;
  //groundhog
  
  PImage robotImg;
  /*float robotRandomX;
  float robotRandomY;//robotPlace*/
/*int xRobot;
  float yRobot;//robot
  float laser;
  float xLaser, yLaser;//laser*/
  
  PImage soldierImg;
  float soldierRandomX;
  float soldierRandomY;
  float soldierSpeedX;//soldierSpeed
  float xSoldier;
  float ySoldier;//soldier//soldierPlace
  
  boolean upPressed;
  boolean downPressed;
  boolean rightPressed;
  boolean leftPressed;

  final int GAME_START = 0;  
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;  
  final int GAME_WIN = 3;
  int gameState = 0;

  final int LIFE_TWO = 0;
  final int LIFE_ONE = 1;  
  final int LIFE_THREE = 2;  
  int gameRunState = 0;
  
void setup() {
  size(640, 480, P2D);
  bgImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhog.png");
  lifeOneImg = loadImage("img/life.png");
  lifeTwoImg = loadImage("img/life.png");
  lifeThreeImg = loadImage("img/life.png");
  robotImg = loadImage("img/robot.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  gameoverImg = loadImage("img/gameover.jpg");
  downImg= loadImage("img/groundhogDown.png");
  rightImg= loadImage("img/groundhogRight.png");
  leftImg= loadImage("img/groundhogLeft.png");
  restartHoveredImg= loadImage("img/restartHovered.png");
  startHoveredImg= loadImage("img/startHovered.png");
  restartNormalImg= loadImage("img/restartNormal.png");
  startNormalImg= loadImage("img/startNormal.png");
  titleImg= loadImage("img/title.jpg");
  cabbageImg= loadImage("img/cabbage.png");
  
  cabbageRandomX = floor(random(6));
  cabbageRandomY = floor(random(4));
  soldierRandomX = floor(random(6));
  soldierRandomY = floor(random(4));
  xSoldier = soldierRandomX*80;
  ySoldier = 160+soldierRandomY*80;//soldierMovement
  
  image(titleImg,0,0);
  image(startNormalImg, buttonX, buttonY);


void draw() 
{ 
  switch(gameState){
    //level1
    case GAME_START :
      if (mouseX > buttonX && mouseX < buttonX+button_W && 
      mouseY > buttonY && mouseY < buttonY+button_H){ 
          image(startHoveredImg, buttonX, buttonY);
          if(mousePressed){gameState=GAME_RUN;}
          }else{image(startNormalImg, buttonX, buttonY);}
          break;
     
    case GAME_RUN :
      //level2
      switch(gameRunState){
        case LIFE_TWO:
          //basic settings
          image(bgImg,0,0);//bg
          fill(124,204,25);
          strokeWeight(0);
          rect(0,145,640,15);//grass
          image(soilImg,0,160);
          //soil
          fill(253,184,19);
          strokeWeight(5);
          stroke(255,255,0);
          ellipse(590,50,120,120);
          //sun
          groundhogX = width/2;
          groundhogY = 80;
          image(groundhogImg,grfinalX,grfinalY);
          //groundhog
          image(lifeOneImg,10,10);
          image(lifeTwoImg,30+50,10);
          //life2s
              
          cabbageRandomX = floor(random(6));
          cabbageRandomY = floor(random(4));
          image(cabbageImg , cabfinalX, cabfinalY);
          //soldier moves
          soldierRandomX = floor(random(6));
          soldierRandomY = floor(random(4));
          image(soldierImg , xSoldier , ySoldier);
          xSoldier = xSoldier+5;
          xSoldier %=640;
          
          //soldier and groundhog touch detection
          if (grfinalX + block >= xSoldier && grfinalX <= xSoldier + block
          && grfinalY == ySoldier ){
          image(groundhogImg,1000,1000);
          image(groundhogImg,5*block,block);
          gameRunState = LIFE_ONE;
          break;  
        }
          
           //eat the cabbage and recover the heart
          if(grfinalX > cabfinalX && grfinalX + block < cabfinalX +block
          && grfinalY > cabfinalY && grfinalY + block < cabfinalY +block){
            image(cabbageImg, cabfinalX+1000, cabfinalY+1000);
            gameRunState = LIFE_THREE;
          }
          break;
          
        case LIFE_ONE :
          image(lifeOneImg,10,10);
          image(lifeTwoImg,30+50,10-block);
          break;
          
        case LIFE_THREE :
          image(lifeThreeImgImg,100+50,10);
          break;    
           }//gamerunstatedash
      
    case GAME_LOSE :
      image(gameoverImg, 0, 0);
      if (mouseX > buttonX && mouseX < buttonX+button_W && 
      mouseY > buttonY && mouseY < buttonY+button_H){ 
          image(restartHoveredImg, buttonX, buttonY);
          if(mousePressed){gameState=GAME_RUN;}
          }else{image(restartNormalImg, buttonX, buttonY);}    
          break;
  }//gamestatedash
}//voiddrawdash

void keyPressed(){
  if (key == CODED) 
    switch (keyCode){
      case DOWN:
        frameRate = 15;
        image(downImg,grfinalX,grfinalY);
        downPressed = true;
        grfinalY = grfinalY+80;
        image(downImg,grfinalX,grfinalY);
        break;      
      case RIGHT:
        frameRate = 15;
        image(rightImg,grfinalX,grfinalY);
        rightPressed = true;
        grfinalX = grfinalX+80;
        image(rightImg,grfinalX,grfinalY);
        break;
      case LEFT:
        frameRate = 15;
        image(leftImg,grfinalX,grfinalY);
        leftPressed = true;   
        grfinalX = grfinalX-80;
        image(leftImg,grfinalX,grfinalY);
        break;
}
}

void keyReleased(){
  if (key == CODED) 
    switch (keyCode){
      case DOWN:
        downPressed = false;
        image(groundhogImg,grfinalX,grfinalY);
        if(grfinalY > height-block){
          grfinalY = height-block;
        }
        break;
      case RIGHT:
        rightPressed = false;
        image(groundhogImg,grfinalX,grfinalY);
        if(grfinalX > width-block){
          grfinalX = width-block;
        }
        break;
      case LEFT:
        leftPressed = false;   
        image(groundhogImg,grfinalX,grfinalY);
        if(grfinalX < 0){
          grfinalX = 0;
        }
        break;
        
    }
  }
