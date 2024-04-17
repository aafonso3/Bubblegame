class BubbleGrid {
  int numCols = 10;
  int numRows = 15;
  color c;
  float rectY = 20;
  BubbleCell[][] cells;
 float initialY;
 
 
  BubbleGrid() {
    //this.c =c;
    cells = new BubbleCell[numCols][numRows];
    initializeGrid();
    
  }
  
void display() {
    for (int col = 0; col < numCols; col++) {
      for (int row = 0; row < numRows; row++) {
        BubbleCell cell = cells[col][row];
        
        if(cell.bubble != null){
          cell.bubble.display();
        }
        cell.display();
      }
    }
   
  }
  
  void update(){
     for (int col = 0; col < numCols; col++) {
      for (int row = 0; row < numRows; row++) {
        BubbleCell cell = cells[col][row];
        cell.update();
      }
     }
  }
    
    void resetPositions() {
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      BubbleCell cell = cells[col][row];
    
      float x = calculateCellX(col,row);
      float y = calculateCellY(row);
       //cell.resetLastTime();
      cell.resetPosition(x, y);
     
    }
  }
}
  
  void initializeGrid() {
    for (int col = 0; col < numCols; col++) {
      for (int row = 0; row < numRows; row++) {
        float x = calculateCellX(col, row);
        float y = calculateCellY(row);
        float size = 25;
        color c = color(255, 200);
        cells[col][row] = new BubbleCell(x, y, size, c);
      }
    }
 
 }
 
   void stopGrid(){
     for (int col = 0; col < numCols; col++) {
      for (int row = 0; row < numRows; row++) {
        BubbleCell cell = cells[col][row];
        cell.stopCell();
      }
     }
  }
    

  float calculateCellX(int col, int row) {
    float size = 25;
    float offset = size / 2 ;
    if (row % 2 == 0) {
      return  42 + offset + col * size;
    } else {
      return 15 + offset + col * size + offset;
    }
  }

  float calculateCellY(int row) {
    float size = 25;
    float offset = 18 + size * cos(radians(30));
    return offset + row * size;
  }
  
  
public ArrayList<BubbleCell> getCellsWithSameColor(BubbleCell initial) {
  ArrayList<BubbleCell> closed = new ArrayList<>();
  ArrayList<BubbleCell> open = new ArrayList<>();

  open.add(initial);

  while (!open.isEmpty()) {
    BubbleCell current = open.remove(0);
    closed.add(current);

    ArrayList<BubbleCell> neighbors = getNonEmptyNeighbors(current);
    for (BubbleCell neighbor : neighbors) {
      if (neighbor.getColor() == initial.getColor() && !closed.contains(neighbor) && !open.contains(neighbor)) {
        open.add(neighbor);
      }
    }
  }

  return closed;
}



public ArrayList<BubbleCell> getNonEmptyNeighbors(BubbleCell cell) {
  ArrayList<BubbleCell> neighbors = new ArrayList<>();
  int colIndex = getCellColumnIndex(cell);
  int rowIndex = getCellRowIndex(cell);

  // Check top neighbor
  if (rowIndex > 0 && !cells[colIndex][rowIndex - 1].isEmpty()) {
    neighbors.add(cells[colIndex][rowIndex - 1]);
  }

  // Check bottom neighbor
  if (rowIndex < numRows -1 && !cells[colIndex][rowIndex + 1].isEmpty()) {
    neighbors.add(cells[colIndex][rowIndex + 1]);
  }

  // Check left neighbor
  if (colIndex > 0 && !cells[colIndex - 1][rowIndex].isEmpty()) {
    neighbors.add(cells[colIndex - 1][rowIndex]);
  }

  // Check right neighbor
  if (colIndex < numCols - 1 && !cells[colIndex + 1][rowIndex].isEmpty()) {
    neighbors.add(cells[colIndex + 1][rowIndex]);
  }

// Check diagonal neighbors
// Even row
if (rowIndex % 2 != 0) {
  if (colIndex > 0 && rowIndex > 0 && !cells[colIndex - 1][rowIndex - 1].isEmpty()) {
    neighbors.add(cells[colIndex - 1][rowIndex - 1]);
  }
  if (colIndex > 0 && rowIndex < numRows - 1 && !cells[colIndex - 1][rowIndex + 1].isEmpty()) {
    neighbors.add(cells[colIndex - 1][rowIndex + 1]);
  }
} else { // Odd row
  if (colIndex < numCols - 1 && rowIndex > 0 && !cells[colIndex + 1][rowIndex - 1].isEmpty()) {
    neighbors.add(cells[colIndex + 1][rowIndex - 1]);
  }
  if (colIndex < numCols - 1 && rowIndex < numRows - 1 && !cells[colIndex + 1][rowIndex + 1].isEmpty()) {
    neighbors.add(cells[colIndex + 1][rowIndex + 1]);
  }
}

  return neighbors;
}
   //<>//

void removeGroupedBalls(ArrayList<BubbleCell> matchedCells) {
  if (matchedCells.size() >= 4) {
    for (BubbleCell cell : matchedCells) {
      int colIndex = getCellColumnIndex(cell);
      int rowIndex = getCellRowIndex(cell);
      // Remover a bola da célula
      cells[colIndex][rowIndex].removeBubble();
    }
  }
}

int getCellColumnIndex(BubbleCell cell) {
  for (int colIndex = 0; colIndex < numCols; colIndex++) {
    for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
      if (cells[colIndex][rowIndex] == cell) {
        return colIndex;
      }
    }
  }
  return -1; // Retorna -1 se a célula não for encontrada
}


int getCellRowIndex(BubbleCell cell) {
  for (int colIndex = 0; colIndex < numCols; colIndex++) {
    for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
      if (cells[colIndex][rowIndex] == cell) {
        return rowIndex;
      }
    }
  }
  return -1; // Retorna -1 se a célula não for encontrada
}


public void freeUnconnectedBubbles() {
  // Fase 1: Marcar todas as células como não ligadas (connected = false)
  for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
    for (int colIndex = 0; colIndex < numCols; colIndex++) {
      if (!cells[colIndex][rowIndex].isEmpty()) {
        cells[colIndex][rowIndex].setConnected(false);
      }
    }
  }

  // Fase 2: Marcar as células ligadas a partir das bolhas do teto
  for (int colIndex = 0; colIndex < numCols; colIndex++) {
    if (!cells[colIndex][0].isEmpty()) {
      markConnectedCells(cells[colIndex][0]);
    }
  }

  Bola b;
   //Liberar as bolhas não ligadas
  for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
    for (int colIndex = 0; colIndex < numCols; colIndex++) {
      BubbleCell cell = cells[colIndex][rowIndex];
      if (!cell.isEmpty() && !cell.isConnected()) {
        b = new Bola(cell.x,cell.y,cell.c);
        b.setVelocity(random(-1,1),5);
        offGridBalls.add(b);
        cell.removeBubble();
        int droppedBalls = offGridBalls.size();
        int pointsPerDroppedBubble = 10 * (int) Math.pow(2, droppedBalls - 1);
        int totalDroppedPoints = droppedBalls * pointsPerDroppedBubble;
        score += totalDroppedPoints;
      
      }
    }
  }
}

private void markConnectedCells(BubbleCell initial) {
  ArrayList<BubbleCell> closed = new ArrayList<>();
  ArrayList<BubbleCell> open = new ArrayList<>();

  open.add(initial);

  while (!open.isEmpty()) {
    BubbleCell current = open.remove(0);
    closed.add(current);
    current.setConnected(true);

    ArrayList<BubbleCell> neighbors = getNonEmptyNeighbors(current);
    for (BubbleCell neighbor : neighbors) {
      if (!neighbor.isConnected() && !closed.contains(neighbor) && !open.contains(neighbor)) {
        open.add(neighbor);
      }
    }
  }
}



void clearGrid() {
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      BubbleCell cell = cells[col][row];
      cell.removeBubble();
    }
  }
}



public boolean isGridEmpty() {
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      if (!cells[col][row].isEmpty() && cells[col][row].getColor() != color(255, 200)) {
        return false;
      }
    }
  }
  return true;
}

void checkGameOver() { //<>//
  for (int colIndex = 0; colIndex < numCols; colIndex++) { //<>//
    for (int rowIndex = 0; rowIndex < numRows; rowIndex++) { //<>//
      if (!cells[colIndex][rowIndex].isEmpty()) { //<>//
        int lastRoWIndex = numRows -1 ;
        float cellY = cells[colIndex][rowIndex].y; //<>//
        BubbleCell cell = cells[colIndex][lastRoWIndex];
        float gameOverLineY = cannon.y - 70; //<>//
 

        if (!cell.isEmpty()) { //<>//
          gameOver(); //<>//
          return; //<>//
        } //<>//
      }
    }
  }
}

void stopCells() {
    for (int colIndex = 0; colIndex < numCols; colIndex++) {
      for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
        BubbleCell cell = cells[colIndex][rowIndex];
        cell.isCellStopped = true; // Define a célula como parada
      }
    }
  }
  
public ArrayList<Color> getUniqueColors() {
  ArrayList<Color> uniqueColors = new ArrayList<>();
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      BubbleCell cell = cells[col][row];
      if (!cell.isEmpty()) {
        uniqueColors.add(new Color(cell.getColor()));
      }
    }
  }
  return uniqueColors;
}


}
