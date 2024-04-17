
class Bola {
  float x; // posição X da bola
  float y; // posição Y da bola
  float speed; // velocidade da bola no eixo X
  float angle ;
  float maxSpeed;
  float velocityX ;
  float velocityY ;
  boolean fired = false;
  float size;
  int removedBallsCount;
  color c;


  
  Bola(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    size  = 25;
    fired = false;
    maxSpeed = 10;
    angle = 0;
    removedBallsCount = 0;
  }
  
  void setStartLocation(float startX, float startY,float startRotation){
    x = startX;
    y = startY;
    angle = startRotation;
    //fired = true;
   
  }
  
   void update(){
  if(fired == true){
    if(speed < maxSpeed){
      speed += 2;
    }
    x += cos(radians(angle-90)) * speed;
    y += sin(radians(angle-90)) * speed;

    // adiciona as condições para quicar na parede
    if(x > width - 35.5) {
      angle =  radians(180) - angle;
    }
    if(x < 35.5){
      angle =  radians(180) - angle;
    }
    if(x < -10 || x > width +10 ||  y> height +10){
      speed = 0;
      fired = false;
    }
  }
}


void movebola(){
  this.x = width/2 - 50;
  this.y = height-50;
}

  void display() {
    pushMatrix();
    fill(c);
    ellipse(x, y, size, size);
    popMatrix();
  }
  
  boolean isFired(){
    return fired;
  }
  
  boolean hitTarget(){
    if(y<-10){
      return true;
    }
    return false;
  }
   public void stopMovement() {
    // Defina o movimento da bola como zero
    speed = 0;
    fired = false;
  }
  
  
boolean isCollided() {
    float minDistance = Float.MAX_VALUE;
    int minColumn = 0;
    int minRow = 0;
    boolean collided = false;
    
     ArrayList<BubbleCell> cellsWithSameColor;
     
     
    
    for (int rowIndex = 0; rowIndex < 15; rowIndex++) {
        for (int colIndex = 0; colIndex < 10; colIndex++) {
            if (bubbleGrid.cells[colIndex][rowIndex].isEmpty()) {
                float cellX = bubbleGrid.cells[colIndex][rowIndex].x;
                float cellY = bubbleGrid.cells[colIndex][rowIndex].y;
                float cellSize = bubbleGrid.cells[colIndex][rowIndex].size / 2;
                
                float distance = dist(firedBall.x, firedBall.y, cellX, cellY);
                
                if (distance < minDistance) {
                    minDistance = distance;
                    minColumn = colIndex;
                    minRow = rowIndex;
                }
            } else {
                float cellX = bubbleGrid.cells[colIndex][rowIndex].x;
                float cellY = bubbleGrid.cells[colIndex][rowIndex].y;
                float cellSize = bubbleGrid.cells[colIndex][rowIndex].size / 2;
                
                float distance = dist(firedBall.x, firedBall.y, cellX, cellY);
                
                if (distance <  ((firedBall.size / 2) + cellSize) ) {
                    collided = true;
                    break;
                }
            }
        }
    }
    
    if (collided) {
         bubbleGrid.cells[minColumn][minRow].changeColor(firedBall.c);
         cellsWithSameColor = bubbleGrid.getCellsWithSameColor(bubbleGrid.cells[minColumn][minRow]);
         bubbleGrid.removeGroupedBalls(cellsWithSameColor);
         bubbleGrid.freeUnconnectedBubbles(); 
         
        removedBallsCount = cellsWithSameColor.size();
        //score += removedBallsCount;
        if (removedBallsCount >= 4) {
            int pointsPerBubble = 25 * (int) Math.pow(2, removedBallsCount - 4);
            int totalPoints = removedBallsCount * pointsPerBubble;
            score += totalPoints;
        }
                  
         return true; 
    } 
            
    return false;
}

  boolean isCollidedWithCeiling(Ceiling c) {
    float minDistance = Float.MAX_VALUE;
    int minColumn = 0;
    
    if (firedBall.y <= c.rectY + firedBall.size/2) {
        for (int colIndex = 0; colIndex < 10; colIndex++) {
            if (bubbleGrid.cells[colIndex][0].isEmpty()) {
                float cellX = bubbleGrid.cells[colIndex][0].x;
                float cellY = bubbleGrid.cells[colIndex][0].y;
                float size  = bubbleGrid.cells[colIndex][0].size / 2;
        
                float distance = dist(firedBall.x, firedBall.y, cellX, cellY);
                
                if (distance < minDistance) {
                    minDistance = distance;
                    minColumn = colIndex;
                }
            }
        }
        
        bubbleGrid.cells[minColumn][0].changeColor(firedBall.c);
        return true;
    }
    
    return false;
}


color getColor(){
  return c;
}
float getPositionX(){
  return x;
}
 float getPositionY() {
    return y; // Retorna a posição y da bola
  }   //<>// //<>//
  
   void setColor(color newColor) {
    this.c = newColor;
  }
  
  
   public void updatePosition() {
        // Atualize a posição da bolha com base na velocidade
        x += velocityX;
        y += velocityY;
    }
      public void setVelocity(float x, float y) {
    this.velocityX = x;
    this.velocityY = y;
  }
  void setFired(){
   this.fired = true;
  }



 public void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }

  
}
