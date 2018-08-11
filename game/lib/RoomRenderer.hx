package lib;

import sk.thenet.anim.*;
import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;
import sk.thenet.plat.Platform;

using sk.thenet.FM;

class RoomRenderer {
  public static inline var ROOM_W = 318;
  public static inline var ROOM_H = 175;
  
  public static var rooms:Map<String, Array<Bitmap>> = new Map();
  
  static var buf:Bitmap;
  
  public static function init(amB:String->Bitmap):Void {
    buf = Platform.createBitmap(ROOM_W * 2, ROOM_H * 2, 0);
    var b = amB("rooms").fluent;
    rooms = [ for (room in Room.INDEX) room.name => {
        [b >> new Cut(room.x * ROOM_W, room.y * ROOM_H, ROOM_W, ROOM_H)];
      } ];
  }
  
  public static function renderRoom(to:Bitmap, ox:Int, oy:Int, r:String):Void {
    to.blitAlpha(rooms[r][0], ox, oy);
  }
  
  public static function renderRooms(ab:Bitmap, room:RoomDisplay):Void {
    switch (room) {
      case Single(r): renderRoom(ab, 0, 0, r);
      case Transitioning(from, dir, to, prog):
      var ox = 0;
      var oy = 0;
      var mx = 0;
      var my = 0;
      switch (dir) {
        case Top: oy = 1; my = -1;
        case Right: mx = 1;
        case Bottom: my = 1;
        case Left: ox = 1; mx = -1;
      }
      renderRoom(buf, ox * ROOM_W, oy * ROOM_H, from);
      renderRoom(buf, ox * ROOM_W + mx * ROOM_W, oy * ROOM_H + my * ROOM_H, to);
      if (mx != 0) {
        for (y in 0...ROOM_H) {
          ab.blitAlphaRect(buf, 0, y, (ox * ROOM_W + (Timing.quartInOut.getF(prog - (y / ROOM_H)) * mx) * ROOM_W).floor(), y, ROOM_W, 1);
        }
      } else {
        /*
        for (x in 0...ROOM_W) {
          ab.blitAlphaRect(buf, x, 0, x, (oy * ROOM_H + (Timing.quartInOut.getF(prog - (x / ROOM_W)) * my) * ROOM_H).floor(), 1, ROOM_H);
        }
        */
        var hw = ROOM_W >> 1;
        for (x in 0...hw) {
          ab.blitAlphaRect(buf, hw + x, 0, hw + x, (oy * ROOM_H + (Timing.quartInOut.getF(prog - (x / hw)) * my) * ROOM_H).floor(), 1, ROOM_H);
          ab.blitAlphaRect(buf, hw - x - 1, 0, hw - x - 1, (oy * ROOM_H + (Timing.quartInOut.getF(prog - (x / hw)) * my) * ROOM_H).floor(), 1, ROOM_H);
        }
      }
    }
  }
}
