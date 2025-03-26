PVector mouseCoord(){
  PVector coord = new PVector(mouseX, mouseY);
  return coord;
}

void menu(){
  rectMode(CENTER);
  fill(blue);
  rect(width/2, height/2, width/10*8, height/10*8, 72);
  fill(black);
  rect(width/2, height/2, width/10*8*0.95, height/10*8*0.95, 720);
  textSize(height/13);
  fill(white);
  textAlign(CENTER, CENTER);
  text("Reprendre (R)", width/2, height/5);
  text("Changer de plateau (C)", width/2, height/5*2);
  text("Recommencer (S)", width/2, height/5*3);
  text("Score (Q)", width/2, height/5*4);
}

void menu(int input){
  rectMode(CENTER);
  fill(blue);
  rect(width/2, height/2, width/10*8, height/10*8, 72);
  fill(black);
  rect(width/2, height/2, width/10*8*0.95, height/10*8*0.95, 72);
  textSize(height/13);
  fill(white);
  textAlign(CENTER, CENTER);
  text("Level 1", width/2, height/6);
  text("Level 2", width/2, height/6*2);
  text("Level 3", width/2, height/6*3);
  text("Level 4", width/2, height/6*4);
  text("Level 5", width/2, height/6*5);
}

void selectLevel(int select){
  switch(select){
    case 1:
      textBoard = loadStrings("levels/level1.txt");
      break;
    case 2:
      textBoard = loadStrings("levels/level2.txt");
      break;
    case 3:
      textBoard = loadStrings("levels/level3.txt");
      break;
    case 4:
      textBoard = loadStrings("levels/level4.txt");
      break;
    case 5:
      textBoard = loadStrings("levels/level5.txt");
      break;
  }
  init();
  isOpen = false;
  levelOpen = false;
}

void winJX(int i){
  rectMode(CENTER);
  fill(pyellow);
  rect(width/2, height/2, width/10*8, height/8, 72);
  fill(black);
  rect(width/2, height/2, width/10*8*0.95, height/8*0.7, 72);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(green);
  switch(i){
    case 0:
      text("Egalité",width/2,height/2*0.98);
      break;
    case 1:
      text("Le joueur 1 a gagné",width/2,height/2*0.98);
      break;
    case 2:
      text("Le joueur 2 a gagné la partie",width/2,height/2*0.98);
      break;
  }
  
}

void displayScore(){
  rectMode(CENTER);
  fill(pyellow);
  rect(width/2, height/2, width/10*8, height/8, 72);
  fill(black);
  rect(width/2, height/2, width/10*8*0.95, height/8*0.7, 72);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(green);
  text("J1: ",width/4,height/2*0.98);
  text(nbJetonJOne,width/4*1.4,height/2*0.98);
  text("J2: ",width/4*2.75,height/2*0.98);
  text(nbJetonJTwo,width/4*3.15,height/2*0.98);
}
