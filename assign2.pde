  PImage bgImg, soilImg,titleImg,robotImg;
  int block = 80;
  
  //badcabbage;(
  PImage cabbageImg;
  float cabbageRandomX;
  float cabbageRandomY;
  float cabfinalX = cabbageRandomX*block;
  float cabfinalY = 2*block+cabbageRandomY*block;
  
  //gooooooood start/end plz
  PImage restartHoveredImg;
  PImage startHoveredImg;
  PImage restartNormalImg;
  PImage startNormalImg;
  PImage gameOverImg;
  int button_W = 144;
  int button_H = 60;
  int buttonX = 248;
  int buttonY = 360;
  
  //the doesn't move groundhog rrrrrrrrr
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
  
  PImage soldierImg;
  float soldierRandomX;
  float soldierRandomY;
  float soldierSpeedX;//soldierSpeed
  float xSoldier;
  float ySoldier;//soldier//soldierPlace
  
  boolean downPressed;
  boolean rightPressed;
  boolean leftPressed;

  final int GAME_START = 0;  
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;  
  int gameState = 0;
  
  int actionFrame;
  
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
  gameOverImg = loadImage("img/gameover.jpg");
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
  
  //the framerate of the groundhog moves
  gameState = GAME_START;
  lastTime = millis();
}

void draw(){ 
  
  switch(gameState){
    
   /* case GAME_START :
      image(titleImg,0,0);
      image(startNormalImg, buttonX, buttonY);
      if (mouseX > buttonX && mouseX < buttonX + button_W 
      && mouseY > buttonY && mouseY < buttonY + button_H){ 
          image(startHoveredImg, buttonX, buttonY);
          if(mousePressed){ gameState = GAME_RUN;
          }
        }
        break;*/
     
    case GAME_RUN :
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
          image(groundhogImg,grfinalX,grfinalY);
          //groundhog
          
          ////////////////////////////////////////////////////////////heart
          if(lifeCount == 2){
            image(life,10,10);
            image(life,80,10);            
          }else if(lifeCount == 3){
            image(life,10,10);
            image(life,80,10);
            image(life,150,10);            
          }else if(lifeCount == 1){           
            image(life,10,10); 
          }else if(lifeCount == 0){
           gameState=Game_LOSE;
          }    
          ///////////////////////////////////////////////////////////
          
          //where's the cabbage 
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
          if (grfinalX + block > xSoldier && grfinalX < xSoldier + block
          && grfinalY == ySoldier ){
          image(groundhogImg,1000,1000);
          image(groundhogImg,5*block,block);
          }
          
          ////////////////////////////////////////////////////////////////////
          //groundhog frame 
          if (downPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogYMove += ONE_BLOCK / 15.0;
              image(downImg, grfinalX, grfinalY);
            } 
          }
      
          if (rightPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXMove += ONE_BLOCK / 15.0;
              image(rightImg, grfinalX, grfinalY);
            }
          }
                
          if (leftPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXMove -= ONE_BLOCK / 15.0;
              image(leftImg, grfinalX, grfinalY);
            }
          }
          ////////////////////////////////////////////////////////////////////////
          
           //eat the cabbage and recover the heart
          if(grfinalX > cabfinalX && grfinalX + block < cabfinalX +block
          && grfinalY > cabfinalY && grfinalY + block < cabfinalY +block){
            image(cabbageImg, cabfinalX+1000, cabfinalY+1000);
            lifeCount == 3;
          }
          break;
      
    case GAME_LOSE :
      image(gameOverImg, 0, 0);
      if (mouseX > buttonX && mouseX < buttonX+button_W && 
      mouseY > buttonY && mouseY < buttonY+button_H){ 
          image(restartHoveredImg, buttonX, buttonY);
          if(mousePressed){
          gameState=GAME_RUN;}
          }else{
            image(restartNormalImg, buttonX, buttonY); 
          break;}
        }}


void keyPressed(){
  if (key == CODED) {
    float newTime = millis();//time when the groundhog started moving
    switch (keyCode){
      case DOWN:
        if (newTime - lastTime > 250) {
        downPressed = true;
        actionFrame = 0;
        grfinalY = grfinalY+80;
        lastTime = newTime;
        if(groundhogY+block > height){
        groundhogY = height-block;
        }
        break; 
      }
      case RIGHT:
        if (newTime - lastTime > 250) {
        rightPressed = true;
        actionFrame = 0;
        grfinalX = grfinalX+80;
        lastTime = newTime;
        if(groundhogX+block > width){
        groundhogX = width-block;
        }
      }
        break;
      case LEFT:
        if (newTime - lastTime > 250) {
        leftPressed = true;   
        actionFrame = 0;
        grfinalX = grfinalX-80;
        lastTime = newTime;
        if(groundhogX+block > width){
        groundhogX = width-block;
        }
        break;
      }
    }  
  }
  

void keyReleased(){
        image(groundhogImg, grfinalX, grfinalY );
  }
