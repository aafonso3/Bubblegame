//import processing.sound.*;

PFont pointsfont;


Cannon cannon;
Ceiling ceiling;
Bola bola;
Bola bola2;
Bola firedBall;
int numRows = 10;
int numCols = 15;
//BubbleCell[][] bubbleGrid = new BubbleCell[d][h];
BubbleCell cells;
BubbleGrid bubbleGrid;
color[] bubbleColors;
//BubbleCell[][] cells;
int removedBallsCount = 0;
int score;
ArrayList<Bola> offGridBalls;
color currentLevelColor;
int currentLevel =1;

ArrayList<Integer> availableColors;





void setup() {
  size(320,700);
  pointsfont  = loadFont("OldEnglishTextMT-48.vlw");

  
  cannon = new Cannon(width / 2, height - 30);
  ceiling = new Ceiling();
  bola = new Bola(width/2, height-30, getRandomBubbleColor());
  bola2 = new Bola(width/2-50, height-30, getRandomBubbleColor());
  bubbleGrid = new BubbleGrid();
  offGridBalls = new ArrayList<Bola>();
  availableColors = new ArrayList<Integer>();
  
   loadLevel("level1.lvl.txt");
  
  //explosionSound = new SoundFile(this, "tiro.mp3");
    
  
  //bubbleCells = new BubbleCell[19];
  //bubbleColors = new color[BubbleGrid.length];
}



void draw() {  
  background(200);

  
    ceiling.displayrect();
    bubbleGrid.display();
    bubbleGrid.update();
    stroke(0);
    strokeWeight(2);
    line(0, cannon.y - 70, width, cannon.y - 70);
      
 
    //bubbleGrid.checkBubbleTouchingLine(cannon.y - 70);
  cannon.display();
  
if (firedBall != null) {
    firedBall.update();
    firedBall.display();
   
    
    if (firedBall.isCollidedWithCeiling(ceiling)) {
        firedBall.stopMovement();
        firedBall = null;
    } else if (firedBall.isCollided()) {
        firedBall.stopMovement();
        firedBall = null;  
   }
}

  bola.update();
  bola2.update();
  for(Bola b : this.offGridBalls)
  {
    b.updatePosition();
  }
  bola2.display();
  bola.display();
  for(Bola b : this.offGridBalls)
  {
    b.display();
  }
  
  ceiling.displaymoldura();
  displayRemovedBalls(score);
        fill(0);
        textFont(pointsfont);
        textSize(20);

        // Exiba o número de bolas removidas no centro da tela
        textAlign(CENTER, CENTER);
        text("Level " + currentLevel, width - 270 , 12);
  
      if (bubbleGrid.isGridEmpty() ) {
    textSize(30);
    textAlign(CENTER);
    fill(0, 255, 0);
    text("Vitória!", width/2, height/2);
    currentLevel++;
     loadLevel("level" + currentLevel + ".lvl.txt");
  } 
  
    checkGameOver();
}

void keyPressed() {
  switch (keyCode) {
    case 32:
      if (firedBall == null || (firedBall != null && firedBall.isCollided())) {
        if (!bola.isFired()) {
          firedBall = bola;
          firedBall.fired = true;
         
          firedBall.setStartLocation(cannon.x, cannon.y, cannon.angle);
          bola = bola2;
          bola.setStartLocation(cannon.x, cannon.y, cannon.angle);
          bola2 = new Bola(width/2-50, height-30, getRandomAvailableBubbleColor());
    
        }
      }
      break;
       case 49: // Tecla 1
      loadLevel("level1.lvl.txt");
      currentLevel = 1;
      break;
    case 50: // Tecla 2
      loadLevel("level2.lvl.txt");
      currentLevel = 2;
      break;
    case 51:
      loadLevel("level3.lvl.txt");
      currentLevel = 3;
      break;
    case 52:
      loadLevel("level4.lvl.txt");
      currentLevel = 4;
      break;
  }
}


void loadLevel(String levelName) {
  String[] lines = loadStrings(levelName); // Carrega o arquivo de texto do nível

  int numRows = lines.length; // número de linhas no arquivo de texto

  String[] firstLineValues = lines[0].split(" "); // Separa os valores da primeira linha
  int numCols = firstLineValues.length; // número de colunas

  // Limpar a grade antes de carregar o novo nível
  bubbleGrid.clearGrid();
  bubbleGrid.resetPositions();
  ceiling.reset();

  ceiling.resetRectPosition();
  score = 0;


  for (int row = 0; row < numRows; row++) {
    String[] values = lines[row].split(" "); // Divide a linha em um array de strings separadas por espaço

    for (int col = 0; col < numCols; col++) {
      int bubbleValue = Integer.parseInt(values[col]); // Obtém o valor da célula do grid
      

      // Crie uma nova BubbleCell com base no valor
      if (bubbleValue > 0) {
        float x = bubbleGrid.calculateCellX(col, row);
        float y = bubbleGrid.calculateCellY(row);
        float size = 25;
        color c = getColorFromValue(bubbleValue); // Implemente essa função para obter a cor correspondente ao valor

        BubbleCell bubbleCell = new BubbleCell(x, y, size, c);
        bubbleCell.empty = false;

        bubbleGrid.cells[col][row] = bubbleCell;
  
      }
    }
  }
  

  
  // Atualize as cores disponíveis para o nível atual
  availableColors.clear();
  for (int row = 1; row < numRows; row++) {
    String[] values = lines[row].split(" "); // Divide a linha em um array de strings separadas por espaço

    for (int col = 0; col < numCols; col++) { //<>//
      int bubbleValue = Integer.parseInt(values[col]); // Obtém o valor da célula do grid //<>//

      // Adicione a cor à lista de cores disponíveis se ainda não estiver presente //<>//
      color c = getColorFromValue(bubbleValue); //<>//
      if (!availableColors.contains(c)) { //<>//
        availableColors.add(c); //<>//
      }
    }
  }
  

}

color getColorFromValue(int value) { 
  color bubbleColor;

  switch (value) {
    case 1:
      bubbleColor = color(255, 0, 0); // Vermelho
      break;
    case 2:
      bubbleColor = color(0, 255, 0); // Verde
      break;
    case 3:
      bubbleColor = color(0, 0, 255); // Azul
      break;
    case 4:
      bubbleColor = color(255, 255, 0); // Amarelo
      break;
    case 5:
      bubbleColor = color(25, 245, 243); // Magenta
      break;
    case 6:
      bubbleColor = color(128, 0, 128); // Ciano
      break;
    default:
      bubbleColor = color(255, 200); // Cor padrão
      break;
  }

  return bubbleColor;
}

color getRandomAvailableBubbleColor() {
  int colorIndex = int(random(availableColors.size()));
  color randomColor = availableColors.get(colorIndex);

  // Verifique se a cor selecionada é branca e escolha outra cor se for o caso
  while (randomColor == color(255,200)) {
    colorIndex = int(random(availableColors.size()));
    randomColor = availableColors.get(colorIndex);
  }

  return randomColor;
}

color getRandomBubbleColor() {
  color[] colors = {color(255, 0, 0), color(0, 0, 255), color(0, 255, 0), color(255, 255, 0)};
  return colors[int(random(colors.length))];
}

   
  public void displayRemovedBalls(int score) {
        // Defina a cor do texto e o tamanho da fonte
        fill(0);
        textFont(pointsfont);
        textSize(20);

        // Exiba o número de bolas removidas no centro da tela
        textAlign(CENTER, CENTER);
        text("Points " + score, width -60, 12);
    }
    
    void gameOver() {
  // Exiba a mensagem de "Game Over!"
  textSize(30);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Game Over!", width/2, height/2);

   bubbleGrid.stopGrid();

 
}

void checkGameOver() {
  for (int colIndex = 0; colIndex < 10; colIndex++) {
    for (int rowIndex = 0; rowIndex < 15; rowIndex++) {
      if (!bubbleGrid.cells[colIndex][rowIndex].isEmpty()) {
        int rowIndexline = 14;
        float cellY = bubbleGrid.cells[colIndex][rowIndex].y;
        BubbleCell cell = bubbleGrid.cells[colIndex][rowIndexline];
        float gameOverLineY = cannon.y - 70;
        if (!cell.isEmpty()) {
          gameOver();
          return;
        }
      }
    }
  }
}
