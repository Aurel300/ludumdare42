package lib;

class Inventory {
  public var slots:Array<Slot> = [ for (y in 0...Room.MAP_HEIGHT) for (x in 0...Room.MAP_WIDTH) null ];
  
  public function new() {
    
  }
}

enum Slot {
  Word(w:Word);
  Map(m:MapFragment);
}
