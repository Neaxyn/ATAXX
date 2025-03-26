class Pion{

  PVector _coord; //X et Y dans le tableau
  int _proprio; //0 = jeu, 1 = joueur 1, 2 = joueur 2, etc...
  String _type; //"Vide" = vide, "Mur" = mur, "Joueur" = jeton qui peut bouger
  boolean _isSelect; //False tout le temps, sauf quand sélectioné
  
  Pion(){
    _proprio = 0;
    _type = "Vide";
    _isSelect = false;
  }
  
  Pion(PVector coord, int proprio, String type){
    _coord = coord;
    _proprio = proprio;
    _type = type;
    _isSelect = false;
  }

  void setProprio(int proprio){ //Change le propriétaire d'un pion
    _proprio = proprio;
  }
  
  void setType(String type){
    _type = type;
  }
  
  void setSelect(boolean select){
    _isSelect = select;
  }
  
  String getType(Pion pion){
    return pion._type;
  }

  
}
