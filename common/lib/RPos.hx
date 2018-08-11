package lib;

abstract RPos(Int) from Int to Int {
  public static inline function xy(x:Int, y:Int):RPos {
    return new RPos(x + y * Room.MAP_WIDTH);
  }
  
  public function new(p:Int) this = p;
  
  public var x(get, never):Int;
  private inline function get_x():Int return this % Room.MAP_WIDTH;
  
  public var y(get, never):Int;
  private inline function get_y():Int return Std.int(this / Room.MAP_WIDTH);
}
