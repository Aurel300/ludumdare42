package lib;

enum RoomDisplay {
  Single(r:RoomState);
  Transitioning(from:RoomState, dir:Direction, to:RoomState, prog:Float);
}
