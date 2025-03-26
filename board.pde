class Board{
  Pion _board[][];
  int _nbCells;
  float _cellSize;
  
  Board(String[] tabBoard){
    //Initialise la taille du plateau
    _nbCells = tabBoard.length;
    
    //On remplit l'affichage avec les cellules
    _cellSize = height/_nbCells;
    
    _board = new Pion [_nbCells][_nbCells];
    
    PVector coord;
    
    //On attribue un type de cellule à chaque case de ce qu'on lit dans le fichier
    for(int i = 0; i<_nbCells; i++){
      for(int j = 0; j<_nbCells; j++){
        coord = new PVector(i, j);
        switch(tabBoard[i].charAt(j)){
          //Si M, on fait un mur
          case 'M':
            _board[i][j] = new Pion(coord, 0, "Mur");
            print("M");
            break;
          //Si R, pion pour joueur 1
          case 'R':
            _board[i][j] = new Pion(coord, 1, "Joueur");
            print("R");
            break;
          //Si B, pion pour joueur 2
          case 'B':
            _board[i][j] = new Pion(coord, 2, "Joueur");
            print("B");
            break;
          //Si autre, case vide pour placer un pion
          default:
            _board[i][j] = new Pion(coord, 0, "Vide");
            print("V");
            break;  
        }
      }
      println();
    }
  }
  
  void drawIt(){
    for (int i = 0 ; i < _nbCells; i++) {
      for (int j = 0 ; j< _nbCells; j++){
        if(_board[i][j]._type == "Mur"){
          drawWall(getCellCenter(i, j));
        }
        if(_board[i][j]._type == "Vide"){
          drawVide(getCellCenter(i, j), white);
        }
        if(_board[i][j]._type == "Joueur"){
          drawPion(getCellCenter(i, j), (_board[i][j]._proprio), (_board[i][j]._isSelect));
        }
      }
    }
  }
  
  //Donne l'indicateur d'une cellule, renvoie ses coordonées en fonction de la taille de la fenêtre
  PVector getCellCenter(float i, float j) {
    PVector Center = new PVector(i*_cellSize+_cellSize/2, j*_cellSize+_cellSize/2);
    return Center;
  }
  
  PVector getCellCenter(PVector coord){
    PVector Center = new PVector(coord.x*_cellSize+_cellSize/2, coord.y*_cellSize+_cellSize/2);
    return Center;
  }
  
  //Recois des coordonées d'une cellule, renvoie son emplacement dans le tableau
  PVector getCellIndic(PVector coordCell){
    PVector cellIndic = new PVector();
    cellIndic.x = int(coordCell.x / _cellSize);
    cellIndic.y = int(coordCell.y / _cellSize);
    return cellIndic;
  }
  
  //Dessine chaque partie du plateau individuellement
  void drawWall(PVector pos){
    fill(beige);
    rectMode(CENTER);
    square(pos.x, pos.y, _cellSize);
  }
  
  void drawVide(PVector pos, color col){
    fill(col);
    rectMode(CENTER);
    square(pos.x, pos.y, _cellSize);
  }
  
  
  void drawPion(PVector pos, int id, boolean select){
    if(select == true){
      drawVide(pos, green);
    }
    else{
      drawVide(pos, white);
    }
    
    if (id == 1){
      fill(red);
    }
    else{
      fill(blue);
    }
    ellipseMode(CENTER);
    circle(pos.x, pos.y, _cellSize);
  }
  
  void selectPion(PVector coord){
    
    for(int i = 0; i<_nbCells; i++){
      for(int j = 0; j<_nbCells; j++){
        if(_board[i][j]._isSelect == true){
          if(movePion(coord, i, j) == true){
            infection(coord);
            deselectPion();
            switch(joueur){
              case 1:
                joueur = 2;
                break;
              case 2:
                joueur = 1;
                break;
            }
            return;
          }
        }
      }
    }
    
    deselectPion();
    
    //Check si là où on a cliqué est un pion  joueur
    
    if (_board[int(coord.x)][int(coord.y)]._type == "Joueur"){
      println("Pion joueur");
      if(_board[int(coord.x)][int(coord.y)]._proprio == joueur){
        _board[int(coord.x)][int(coord.y)].setSelect(true);
        drawPion(getCellCenter(coord), _board[int(coord.x)][int(coord.y)]._proprio, _board[int(coord.x)][int(coord.y)]._isSelect);
      }
    }
    
    
  }
  
  boolean movePion(PVector coord, int x, int y){
    if(_board[int(coord.x)][int(coord.y)]._type == "Vide"){
      
      if(((int(coord.x)-x <= 1) && (int(coord.x)-x >= -1)) && ((int(coord.y)-y <= 1) && (int(coord.y)-y >= -1))){
        _board[int(coord.x)][int(coord.y)].setType("Joueur");
        _board[int(coord.x)][int(coord.y)].setProprio(joueur);
        return true;
       }
       
       if(((int(coord.x)-x <= 2) && (int(coord.x)-x >= -2)) && ((int(coord.y)-y <= 2) && (int(coord.y)-y >= -2))){
         _board[x][y] = new Pion();
         _board[int(coord.x)][int(coord.y)].setType("Joueur");
         _board[int(coord.x)][int(coord.y)].setProprio(joueur);
         return true;
       }
       
       return false;
       
    }
    return false;
  }
  
  void deselectPion(){
    for(int i = 0; i<_nbCells; i++){
      for(int j = 0; j<_nbCells; j++){
        if(_board[i][j]._type == "Joueur"){
          _board[i][j].setSelect(false);
        }
      }
    }
  }
  
  //Check autour de l'arrivée du pion si y a des pions enemies
  void infection(PVector coord){
    for ( int i = -1 ; i <= 1 ; i++){
      for ( int j = -1 ; j <= 1 ; j++){
        if(_board[int(coord.x)+i][int(coord.y)+j]._proprio != joueur){
          _board[int(coord.x)+i][int(coord.y)+j]._proprio = joueur;
        }
      }
    }
  }
  
  //Return true si partie terminée, sinon, retourne false
  boolean verifWin(){
    nbJetonJOne = 0;
    nbJetonJTwo = 0;
    for(int i = 0; i<_nbCells; i++){
      for(int j = 0; j<_nbCells; j++){
        
        //On compte le nb de jeton de chaque joueur
        if(_board[i][j]._type == "Joueur"){
          if(_board[i][j]._proprio == 1){
            nbJetonJOne += 1;
          }
          if(_board[i][j]._proprio == 2){
            nbJetonJTwo += 1;
          }
        }
        
      }
    }
    
    //Si on joueur n'as plus de jeton, la partie est finie
    if(nbJetonJOne == 0){
       winJX(2);
    }
    else if( nbJetonJTwo == 0){
       winJX(1);
    }
    
    //Si plateau plein, on renvoie que la partie est finie et le gagnant est celui avec le plus de jeton
    for(int i = 0; i<_nbCells; i++){
      for(int j = 0; j<_nbCells; j++){
        
        if(_board[i][j]._type == "Vide"){
          return false;
        }
        
        
        
      }
    }
    if(nbJetonJOne > nbJetonJTwo){
      winJX(1);
    }
    if(nbJetonJOne < nbJetonJTwo){
      winJX(2);
    }
    if(nbJetonJOne == nbJetonJTwo){
      winJX(0);
    }
    return(true);
  }
  
  //Si tour du joueur 1, plateau rouge. Sinon, plateau bleu.
  void checkTourJoueur(int id){
    if(id == 1){
      stroke(red);
    }
    else{
      stroke(blue);
    }
  }
  
}
