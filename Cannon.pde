class Cannon{
  int x, y;
  float angle;
  int length; // comprimento do canhão 
  int thickness;
  float angularVelocity; // velocidade angular em graus/segundo
  float maxAngle; // ângulo máximo permitido para o canhão
  float rotation;
  float maxRotation = 60;
  float currentRotation = 0;
  float speed;
  float maxspeed;
  float friction;
  

  
  Cannon(int x, int y){
   this.x = x;
   this.y = y;
    angle = 0;
    length = 80;
    thickness  = 25;
    speed = 0; // velocidade angular em graus/segundo
    maxAngle = 60; // ângulo máximo permitido para o canhão
    rotation = 0;
    maxspeed = 10;
    friction = 0.9;
  }
 
  void display(){
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    fill(70);
    noStroke();
    rect(-thickness/2, thickness/4, thickness, -thickness*3 + 20, 12, 24, 48, 72);
 
        popMatrix();
    if(keyPressed){
    if(keyCode == LEFT){
      rotateleft();
    }else if (keyCode == RIGHT){
      rotateright();
    }
  }

  }
  
  void rotateright(){
    if(angle <60){
    angle += 45/60.0;
    angle = min(angle,60);
    }
}

void rotateleft(){
  if(angle > -60){
  angle -= 45/60.0;
  angle = max(angle, -60);
  }
}
float getAngle(){
  return angle;
}
}
  
 
