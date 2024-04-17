class BubbleCell {
  float x; // posição X da célula
  float y ; // posição Y da célula
  float size; // tamanho da célula
  color c;
  float lastTime = 0;
  float timeInterval = 20000;
  Bola bubble;
  boolean empty;
  int col;
  int row;
  boolean connected;
  float velocityY;
  float velocityX;
  BubbleGrid bubbleGrid;
  boolean isCellStopped = false;
  boolean isRectStopped = false;
  float initialY ;


  BubbleCell(float x, float y, float size, color c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.c = c;
    this.empty = true;
    velocityY = 0;
    velocityX = 0;

    

  }
  
  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
  }
  
  void update(){
         if (isCellStopped) {
    // A célula está parada, não atualize a posição
    return;
  }
        if (isRectStopped) {
    // A célula tocou na linha, pare o movimento
    stopCell();
    return;
  }
    
     if (millis() - lastTime > timeInterval) {
      lastTime = millis();
      y += 20; 
    }
  }
  
    void changeColor(color newColor) {
      c = newColor;
      this.empty = false;
    }
    
    boolean isEmpty(){
      return empty;
    }
    color getColor(){
      return c;
    }
      void setBubble(Bola bubble) {
    this.bubble = bubble;
  }
   boolean isFilled() {
    return bubble != null;
  }
  
  boolean setEmpty(){
    return empty == false;
  }
  
  boolean setEmpty2(){
    return empty == true;
  }
  
void removeBubble() {
    this.empty = true;
    this.c = color(255, 200);
    this.bubble = null;
}
  void setColor(color c) {
  this.c = c;
}

 public void setConnected(boolean connected) {
    this.connected = connected;
  }

  public boolean isConnected() {
    return connected;
  }

  public void setVelocity(float velocityX, float velocityY) {
    this.velocityX = velocityX;
    this.velocityY = velocityY;
  }

  public Bola getBubble() {
  return bubble;
}

public void clear() {
  bubble = null;
}

void stopCell() {
  isCellStopped = true; // Define a célula como parada
}

 public void setPosition(float x, float y) {
    this.x = x;
    this.x = y;
    if (this.bubble != null) {
      this.bubble.setPosition(x, y);
    }
  }

void resetPosition(float x, float y) {
  
  this.x = x;
  this.y = y ;
  initialY = y;
   lastTime = 0;
}



}
