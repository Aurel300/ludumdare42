package lib;

class Room {
  public static var INDEX:Map<String, Room> = [
    "start" => new Room(0, 0, [], [])
  ];
  
  public var x:Int;
  public var y:Int;
  public var interactives:Array<String>;
  public var exits:Array<Exit>;
  
  public function new(x:Int, y:Int, i:Array<String>, e:Array<Exit>) {
    this.x = x;
    this.y = y;
    this.interactives = i;
    this.exits = e;
  }
}

class Exit {
  public var to:String;
  public var pos:ExitPosition;
  public var open:Bool;
  
  public function new(to:String, pos:ExitPosition, ?open:Bool = true) {
    this.to = to;
    this.pos = pos;
    this.open = open;
  }
}

enum ExitPosition {
  Top;
  Left;
  Right;
  Bottom;
}
