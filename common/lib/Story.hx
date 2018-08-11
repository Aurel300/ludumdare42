package lib;

class Story {
  public static var flags:Map<String, Bool> = [
      "started" => false
    ];
  
  public static var ops = Operations.INDEX;
  public static var words = Word.INDEX;
  public static var inv:Inventory;
  
  public static function initNew():Void {
    inv = new Inventory();
    inv.slots[0] = Map({x: 0, y: 0, explored: true});
    inv.slots[1] = Map({x: 1, y: 0, explored: false});
  }
}
