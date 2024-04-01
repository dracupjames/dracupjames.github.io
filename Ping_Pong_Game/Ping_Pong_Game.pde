float x;
float y;
float w;
float h;
float sx;
float sy;
float paddlex;
float paddley; 
float paddlex1;
float paddley1;
float paddlew;
float paddleh;
float paddles1;
float paddles2;
boolean upL;
boolean downL;
boolean upR;
boolean downR;
int scorel=0;
int scorer=0;
int winscore=5;
boolean gameStarted = false;
boolean firstTime = true; // Variable to track if it's the first time the game is played

void setup(){
  size(600,500);
  background(255);
  x=width/2;
  y=height/2;
  w=30; 
  h=30; 
  sx= 0; // Initialize speed to 0
  sy= 0; // Initialize speed to 0
  paddlex=width/2-280; 
  paddley=height/2;
  paddlew=20; paddleh=50; paddles1=5; paddles2=5;
  paddlex1=width/2+260; 
  paddley1=height/2; 
  noStroke();
  textSize(40);
  frameRate(50);
}

void draw(){
  background(255);
  
  if (firstTime) { // If it's the first time the game is played
    textAlign(CENTER, CENTER);
    fill(0);
    text("Click to play", width/2, height/2);
  } else if (!gameStarted) { // If the game has not started and it's not the first time
    textAlign(CENTER, CENTER);
    fill(0);
    text("Click to play again", width/2, height/2);
  }
  
  if (gameStarted) { // If the game has started, update puck position
    fill(255,0,0);
    ellipse(x,y,w,h);
    x=x+sx;
    y=y+sy;
    if (x+w/2>width){
      x=width/2;
      y=height/2;
      scorel=scorel+1;
      sx= -2;
      sy= random(-2,2);
      paddles1 = 5;
      paddles2 = 5;
    }
    else if (x-w/2<0){
      x=width/2;
      y=height/2;
      scorer=scorer+1;
      sx = -2;
      sy = random(-2,2);
      paddles1 = 5;
      paddles2 = 5;
    }     
    if ((y>height-h/2)||(y<0+h/2)){ 
      sy=-sy;   
    }
  }

  //Paddle 1 && Paddle2
  fill(0,255,0);
  rect(paddlex,paddley,paddlew,paddleh);
  fill(0,0,255);
  rect(paddlex1,paddley1,paddlew,paddleh);
  
  if(upL){
    paddley=paddley-paddles1;
  } else if(downL){
    paddley=paddley+paddles1;
  } 
  if (upR){
    paddley1=paddley1-paddles2;
  } else if (downR){
    paddley1=paddley1+paddles2;
  }
  if (paddley<0){
    paddley=paddley+paddles1;
  } else if (paddley>height-50){
    paddley=paddley-paddles1;
  } 
  if (paddley1<0){
    paddley1=paddley1+paddles2;
  } else if (paddley1>height-50){
    paddley1=paddley1-paddles2;
  }
  
  //Contact between paddles & ball
  if(x-(w/2)<paddlex+paddlew && y-(h/2)<paddley+paddleh && y-(h+5)>paddley-paddleh){
    sx=-sx+.25;
    sy += 0.25;
    paddles1=paddles1+.25;
    paddles2=paddles2+.25;    
  }
  if(x-(w/2)>paddlex1-w && y-(h/2)<paddley1+paddleh && y-(h+5)>paddley1-paddleh){
    sx=-sx-.25;
    sy += 0.25;
    paddles1=paddles1+.25;
    paddles2=paddles2+.25; 
  }
  
  //Gameover && Reset
  fill(0);
  text(scorer,width/2+100,50);
  text(scorel,width/2-100,50);
  textAlign(CENTER,CENTER);
  
  if(scorel==winscore){
    fill(0);
    text("Game Over",width/2,height/2-150);
    fill(0,255,0);
    text("Green Wins!",width/2,height/2-100);
    sx=0;
    sy=0;
    gameStarted = false; // Stop the game
  } else if(scorer==winscore){
    fill(0);
    text("Game Over",width/2,height/2-150);
    fill(0,0,255);
    text("Blue Wins!",width/2,height/2-100);
    sx=0;
    sy=0;
    gameStarted = false; // Stop the game
  }
}

void mousePressed(){
  if (!gameStarted) { // If the game has not started and the mouse is clicked
    gameStarted = true; // Start the game
    resetGame(); // Reset the game state
    if (firstTime) { // If it's the first time the game is played
      firstTime = false; // Set firstTime to false
    }
  }
}

void resetGame() {
  scorel=0;
  scorer=0;
  sy = int(random(-4,4)); // Reset vertical velocity
  while (sy == -1 || sy == 0 || sy == 1){
    sy = int(random(-4,4)); 
  }
  sx = int(random(-5, 5));

  // Make sure sx is not -1, 0, or 1
  while (sx == -1 || sx == 0 || sx == 1) {
    sx = int(random(-5, 5));
  }
  paddley=height/2; // Reset the position of the left paddle
  paddley1=height/2; // Reset the position of the right paddle
}

void keyPressed(){
  if (key=='w' || key=='W'){
    upL=true;
  }
  if (key=='s' || key=='S'){
    downL=true;
  }
  if (key=='i' || key=='I'){
    upR=true;
  }
  if (key=='j' || key=='J'){
    downR=true;
  }
}

void keyReleased(){
  if (key=='w' || key=='W'){
    upL=false;
  }
  if (key=='s' || key=='S'){
    downL=false;
  }
  if (key=='i' || key=='I'){
    upR=false;
  }
  if (key=='j' || key=='J'){
    downR=false;
  }
}
