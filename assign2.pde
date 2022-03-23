  PImage bgImg, soilImg,titleImg,robotImg,lifeImg,cabbageImg;
  int block = 80;
  float lifeCount = 2;
  
  //badcabbage;(
  float cabbageRandomX;
  float cabbageRandomY;
  float cabfinalX;
  float cabfinalY;
  
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
  float groundhogXPlus;
  float groundhogYPlus;
  PImage downImg;
  PImage rightImg;
  PImage leftImg;
  //groundhog
  
  PImage soldierImg;
  float soldierRandomX;
  float soldierRandomY;
  float soldierSpeedX;//soldierSpeed
  float xSoldier;
  float ySoldier;//soldier//soldierPlace
  
  boolean downPressed = false;
  boolean rightPressed = false;
  boolean leftPressed = false;

  final int GAME_START = 0;  
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;  
  int gameState = GAME_START;
  
  int actionFrame;
  float newTime = millis();//time when the groundhog started moving (1)
  float lastTime = millis();//last groundhog moving (14)
  
void setup() {
  
  size(640, 480, P2D);
  bgImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhogIdle.png");
  lifeImg = loadImage("img/life.png");
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
  frameRate(60);
  gameState = GAME_START;
  lastTime = millis();
  
  cabbageRandomX = floor(random(7));
  cabbageRandomY = floor(random(4));
}

void draw(){ 
  
  switch(gameState){
   
   case GAME_START :
      image(titleImg,0,0);
      image(startNormalImg, buttonX, buttonY);
      if (mouseX > buttonX && mouseX < buttonX + button_W 
      && mouseY > buttonY && mouseY < buttonY + button_H){ 
          image(startHoveredImg, buttonX, buttonY);
          if(mousePressed){ 
            gameState = GAME_RUN;
          }
        }
        break;
     
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
          
          image(groundhogImg,groundhogX, groundhogY);
          /////////////////////////////boundary detection
          if(groundhogY >= height){
          groundhogY = height-block;
          }//down boundary
          
          if(groundhogX >= width){
          groundhogX = width-block;
          }//right boundary
          
          if(groundhogX <= 0){
          groundhogX = 0;
          } //left boundary
          ///////////////////////////////groundhog      
          
          //heart
          if(lifeCount == 2){
            image(lifeImg,10,10);
            image(lifeImg,80,10);   
            gameState = GAME_RUN;
          }else if(lifeCount == 3){
            image(lifeImg,10,10);
            image(lifeImg,80,10);
            image(lifeImg,150,10);  
            gameState = GAME_RUN;
          }else if(lifeCount == 1){           
            image(lifeImg,10,10); 
            gameState = GAME_RUN;
          }else if(lifeCount <= 0){
           gameState = GAME_LOSE;
           break;
          }  
                  
          //soldier moves
          soldierRandomX = floor(random(7));
          soldierRandomY = floor(random(4));
          image(soldierImg , xSoldier , ySoldier);
          xSoldier = xSoldier+5;
          xSoldier %=640;
          
            
          //soldier and groundhog touch detection
          if (groundhogX >= xSoldier && groundhogX + block <= xSoldier + block
          && groundhogY == ySoldier ){
          groundhogX = 4*block;
          groundhogY = block;
          lifeCount -= 1;
          if (lifeCount < 1){
          gameState = GAME_LOSE;
            }
          }
          
          //where's the cabbage 
          float cabfinalX = cabbageRandomX*block;
          float cabfinalY = 2*block+cabbageRandomY*block;
          image(cabbageImg , cabfinalX, cabfinalY);
          
          //eat the cabbage and recover the heart
          if(groundhogX >= cabfinalX && groundhogX + block <= cabfinalX +block
          && groundhogY >= cabfinalY && groundhogY + block <= cabfinalY +block){
            cabfinalX = -1000;
            cabfinalY = -1000;
            lifeCount += 1;            
            if (lifeCount > 3){
            lifeCount = 3;
            }  
      //////////////////////////////////////////////////////////////////////////framerate setting   
          //groundhog frame 
          if (downPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogYPlus += block / 15.0;
              image(downImg, groundhogX, groundhogY + groundhogYPlus);
            } else {
              groundhogY = groundhogY + block;
              downPressed = false;
         }
        }
      
          if (rightPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXPlus += block / 15.0;
              image(rightImg, groundhogX + groundhogXPlus, groundhogY);
            } else {
              groundhogX = groundhogX + block;
              rightPressed = false;
         }
        }
                
          if (leftPressed) {
            actionFrame++;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXPlus -= block / 15.0;
              image(leftImg, groundhogX, groundhogY);
            } else {
              groundhogX = groundhogX - block;
              leftPressed = false;
         }
        }
 }       
          break;
          ////////////////////////////////////////////////////////////////////////
          
      
    case GAME_LOSE :
      image(gameOverImg, 0, 0);
      image(restartHoveredImg, buttonX, buttonY);
      if (mouseX > buttonX && mouseX < buttonX + button_W 
      && mouseY > buttonY && mouseY < buttonY + button_H){ 
          if(mousePressed){ 
            lifeCount = 2;
            cabbageRandomX = floor(random(7));
            cabbageRandomY = floor(random(4));
            soldierRandomX = floor(random(7));
            soldierRandomY = floor(random(4));
            groundhogX = 4*block;
            groundhogY = block;
            image(groundhogImg, groundhogX, groundhogY);
            gameState = GAME_RUN;
          }
          break;}
        }}

void keyPressed(){
  float newTime = millis();
  if (key == CODED) {
    switch (keyCode){
      case DOWN:
        downPressed = true;
        actionFrame = 0;
        groundhogY = groundhogY+block;
        lastTime = newTime; 
      break;
      
      case RIGHT:
        rightPressed = true;
        actionFrame = 0;
        groundhogX = groundhogX+block;
        lastTime = newTime;
      break;
      
      case LEFT:
        leftPressed = true;   
        actionFrame = 0;
        groundhogX = groundhogX-block;
        lastTime = newTime;
      break;
    }  
  }
}

void keyReleased(){
        image(groundhogImg, groundhogX, groundhogY );
}
