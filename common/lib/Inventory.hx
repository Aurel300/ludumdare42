package lib;

class Inventory {
  public var slots:Array<Slot> = [ for (y in 0...Room.MAP_HEIGHT) for (x in 0...Room.MAP_WIDTH) Empty ];
  
  public function new() {
    
  }
}
