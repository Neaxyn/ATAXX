int idJoueurActuel = 0;
Board board;
String[] textBoard;
int joueur = 0;
int tour = 0;
boolean isOpen = false;
boolean levelOpen = false;
boolean affichScore = false;
int nbJetonJOne = 0;
int nbJetonJTwo = 0;

void setup(){
  size(800, 800);
  textBoard = loadStrings("levels/level1.txt");
  init();
}

void draw(){
  board.checkTourJoueur(joueur);
  board.drawIt();
  if(isOpen == true){
    menu();
  }
  if(levelOpen == true){
    menu(1);
  }
  if(affichScore == true){
    displayScore();
  }
  if(board.verifWin()){
    noLoop(); //Ajouter affichage de qui gagne
  }
}

void init(){
  board = new Board(textBoard);
  tour = 1;
  joueur = 1;
}

void mousePressed() {
  board.selectPion(board.getCellIndic(mouseCoord()));
}

void keyPressed(){
  redraw();
  if(key == 27){  //Echap pressé
      key = 0;
      levelOpen = false;
      affichScore = false;
      isOpen = true;
      menu();
  }
  if(key == 'r'){
    if(isOpen == true){
      isOpen = false;
    }
  }
  if(key == 'c'){
    if(isOpen == true){
      levelOpen = true;
    }
  }
  if(key == 's'){
    if(isOpen == true){
      init();
      isOpen = false;
    }
  }
  if(key == 'q'){
    if(isOpen == true){
      isOpen = false;
      affichScore = true;
    }
  }
  
  if(key == '&'){
    if(levelOpen == true){
      selectLevel(1);
    }
  }
  if(key == 'é'){
    if(levelOpen == true){
      selectLevel(2);
    }
  }
  if(key == '\"'){
    if(levelOpen == true){
      selectLevel(3);
    }
  }
  if(key == '\''){
    if(levelOpen == true){
      selectLevel(4);
    }
  }
  if(key == '('){
    if(levelOpen == true){
      selectLevel(5);
    }
  }
  
}
