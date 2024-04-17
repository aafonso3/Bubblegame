public class Ceiling{
  float x;
  float y;
  color c;
  float lastTime = 0;
  float timeInterval = 20000;
  float rectY = 20;
boolean isRectStopped = false; // Variável para controlar se o retângulo está parado


 public void reset() {
    rectY = 20; // Define a posição inicial do retângulo
    lastTime = millis(); // Reinicializa o tempo para o efeito de movimento
  }
  
  
  public void displaymoldura(){
   
    stroke(255,255,0);
    strokeWeight(48);
    // Desenha a moldura
    line(0, 0, width, 0);
    line(width, 0, width, height);
    line(0, height, 0, 0);
    
  }

  public void displayrect(){
    fill(250,237,237);
    strokeWeight(10);
    rect(20, rectY, width, height / 2 + 50 );
    
      if (isRectStopped) {
    // O retângulo está parado, não atualize a posição
    return;
  }
  
  if (rectY + height / 2 + 60 >= cannon.y - 70) {
    // O retângulo tocou na linha, pare o movimento
    stopRect();
    return;
  }

     if (millis() - lastTime > timeInterval) {
      lastTime = millis();
      rectY += 20; // Move o retângulo 10 pixels para baixo
    }

   
}
public void resetRectPosition() {
  rectY = 20; // Define a posição inicial do retângulo
  isRectStopped = false; // Reinicia a variável de controle do movimento do retângulo
}


void stopRect() {
  isRectStopped = true; // Define o retângulo como parado
}

  
}
