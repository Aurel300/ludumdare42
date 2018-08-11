package lib;

import lib.Room.ExitPosition;

enum RoomDisplay {
  Single(r:String);
  Transitioning(from:String, dir:ExitPosition, to:String, prog:Float);
}
