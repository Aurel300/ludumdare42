package lib;

import sk.thenet.anim.*;
import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;
import sk.thenet.plat.Platform;

import lib.RoomState.RsObject;

using sk.thenet.FM;

class RoomRenderer {
  public static inline var ROOM_W = 318;
  public static inline var ROOM_H = 175;
  public static inline var TILE_W = 20;
  public static inline var TILE_H = 25;
  public static inline var ROOM_TILES_W = 16;
  public static inline var ROOM_TILES_H = 7;
  public static inline var TILE_OX = 9;
  public static inline var TILE_OY = 125 - 2;
  
  public static var rooms:Map<String, Array<Bitmap>> = new Map();
  
  public static function init(amB:String->Bitmap):Void {
    var bs = [ for (f in 0...7) amB("floor" + f).fluent ];
    rooms = [ for (room in Room.INDEX) room.name => {
        var mg = 0;
        for (l in room.layers) switch (l) {
          case Ground(y): mg = mg.maxI(y);
          case _:
        }
        [ for (i in 0...mg + 1) bs[room.y] >> new Cut(room.x * ROOM_W, i * ROOM_H, ROOM_W, ROOM_H)];
      } ];
  }
  
  var buf1:Bitmap;
  var buf2:Bitmap;
  var game:SGame;
  
  var lastExitClicked:Null<RoomObject> = null;
  var doubleClick:Int = 0;
  
  public function new(s:SGame) {
    buf1 = Platform.createBitmap(ROOM_W, ROOM_H, 0);
    buf2 = Platform.createBitmap(ROOM_W, ROOM_H, 0);
    game = s;
  }
  
  function checkMouseAll(s:RoomState, mx:Int, my:Int):Bool {
    for (o in s.room.objects) if (checkMouseObject(o, s, mx, my)) return true;
    for (o in s.objects) if (checkMouseRsObject(o, mx, my)) return true;
    return false;
  }
  
  function checkMouseRsObject(o:RsObject, mx:Int, my:Int):Bool {
    return (switch (o) {
        case Ragdoll(_, rd, _, interactive):
        interactive != null && mx.withinI(rd.xMin, rd.xMax - 1) && my.withinI(rd.yMin, rd.yMax - 1);
        case _: false;
      });
  }
  
  function checkMouseObject(o:RoomObject, s:RoomState, mx:Int, my:Int):Bool {
    var tx = ((mx - TILE_OX) / TILE_W).floor();
    var ty = ((my - TILE_OY) / TILE_H).floor();
    return (switch (o) {
      case Exit(tileX, tileY, tileW, tileH, dir, _):
      s.openExits.indexOf(dir) != -1 && tx.withinI(tileX, tileX + tileW - 1) && ty.withinI(tileY, tileY + tileH - 1);
      case Interaction(name, tileX, tileY, tileW, tileH):
      if (s.room.name == "slick" && s.enteredFrom != Top) return false;
      tx.withinI(tileX, tileX + tileW - 1) && ty.withinI(tileY, tileY + tileH - 1);
      case _: false;
    });
  }
  
  public function mouseClick(mx:Int, my:Int):Bool {
    switch (game.room) {
      case Single(r):
      for (o in r.room.objects) if (checkMouseObject(o, r, mx, my)) switch (o) {
        case Exit(tileX, tileY, tileW, tileH, pos, climb):
        if (r.room.name == "slick") {
          if (lastExitClicked == o && doubleClick >= 0) {
            var to = game.roomStates[r.room.exitMap[pos].to];
            game.room = Transitioning(r, pos, to, 0);
            Sfx.play("transition", .3);
            to.enter(Direction.OPPOSITE[pos]);
          } else r.playerAq.enqueue(((switch (pos) {
            case Right: [SlipTo(ROOM_TILES_W)];
            case _: [SlipTo(-1)];
          }:Array<lib.AnimationQueue.AnimationStep>)).concat([Function(() -> {
            var to = game.roomStates[r.room.exitMap[pos].to];
            game.room = Transitioning(r, pos, to, 0);
            Sfx.play("transition", .3);
            to.enter(Direction.OPPOSITE[pos]);
          })]));
        }
        if (lastExitClicked == o && doubleClick >= 0) {
          var to = game.roomStates[r.room.exitMap[pos].to];
          game.room = Transitioning(r, pos, to, 0);
          Sfx.play("transition", .3);
          to.enter(Direction.OPPOSITE[pos]);
        } else r.playerAq.enqueue(((switch (pos) {
          case Top: [WalkTo(tileX + 1), ClimbTo(-2)];
          case Right: [WalkTo(ROOM_TILES_W)];
          case Bottom: [WalkTo(tileX + 1), ClimbTo(2)];
          case Left: [WalkTo(-1)];
          case _: [];
        }:Array<lib.AnimationQueue.AnimationStep>)).concat([Function(() -> {
          var to = game.roomStates[r.room.exitMap[pos].to];
          game.room = Transitioning(r, pos, to, 0);
          Sfx.play("transition", .3);
          to.enter(Direction.OPPOSITE[pos]);
        })]));
        lastExitClicked = o;
        doubleClick = 50;
        return true;
        case Interaction(name, tileX, tileY, tileW, tileH):
        r.playerAq.enqueue([WalkFinish, Function(() -> {
            var ipos = (TILE_OX + tileX * TILE_W + TILE_OX + (tileX + tileW) * TILE_W) / 2;
            game.cameraTX = UI.DIALOGUE_HIGHLIGHT - ipos;
            game.ui.activateInteractive(name);
          })]);
        case _:
      }
      for (o in r.objects) if (checkMouseRsObject(o, mx, my)) switch (o) {
        case Ragdoll(_, rd, _, interactive):
        if (interactive != null) {
          r.playerAq.enqueue([WalkFinish, Function(() -> {
              var ipos = (rd.xMin + rd.xMax) / 2;
              game.cameraTX = UI.DIALOGUE_HIGHLIGHT - ipos;
              game.ui.activateInteractive(interactive);
            })]);
          return true;
        }
        case _:
      }
      case _:
    }
    return false;
  }
  
  public function renderRoom(to:Bitmap, s:RoomState):Void {
    for (l in s.room.layers) switch (l) {
      case Ragdoll(name): for (o in s.objects) switch (o) {
        case Ragdoll(oname, rd, aq, interactive):
        if (name != oname) continue;
        rd.renderGlow(
             to, TILE_OX + aq.tileX * TILE_W, TILE_OY + aq.tileY * TILE_H + aq.realY.round(), 0
            ,aq.maxPos
          );
        aq.tick();
        case _:
      }
      case Visual(name): RoomVisual.INDEX[name](s, to);
      case Ground(y): to.blitAlpha(rooms[s.room.name][y], 0, 0);
      case Colour(index): to.fill(Pal.P[index]);
      case _:
    }
  }
  
  public function tick(mx:Int, my:Int):Void {
    switch (game.room) {
      case Transitioning(from, dir, to, prog):
      var nprog = prog + 0.05;
      game.room = nprog >= 2 ? Single(to) : Transitioning(from, dir, to, nprog);
      case Single(s):
      if (checkMouseAll(s, mx, my)) {
        game.ui.cursor = Action;
      }
    }
  }
  
  public function renderRooms(ab:Bitmap, cameraX:Int):Void {
    if (doubleClick > 0) doubleClick--;
    switch (game.room) {
      case Single(r):
      renderRoom(buf1, r);
      game.ui.mapText = r.room.desc;
      if (r.room.name == "mishap") ab.blitAlpha(buf1.fluent >> new Flip(true), cameraX, 0);
      else ab.blitAlpha(buf1, cameraX, 0);
      case Transitioning(from, dir, to, prog):
      lastExitClicked = null;
      var ox = 0;
      var oy = 0;
      var mx = 0;
      var my = 0;
      switch (dir) {
        case Top: oy = 1; my = -1; renderRoom(buf1, to); renderRoom(buf2, from);
        case Right: mx = 1; renderRoom(buf1, from); renderRoom(buf2, to);
        case Bottom: my = 1; renderRoom(buf1, from); renderRoom(buf2, to);
        case Left: ox = 1; mx = -1; renderRoom(buf1, to); renderRoom(buf2, from);
      }
      if (mx != 0) {
        for (y in 0...ROOM_H) {
          var scan = (ox * ROOM_W + (Timing.quartInOut.getF(prog - (y / ROOM_H)) * mx) * ROOM_W).floor();
          ab.blitAlphaRect(buf1, cameraX, y, scan, y, ROOM_W - scan, 1);
          ab.blitAlphaRect(buf2, cameraX + ROOM_W - scan, y, 0, y, scan, 1);
        }
      } else {
        var hw = ROOM_W >> 1;
        for (x in 0...hw) {
          var scan = (oy * ROOM_H + (Timing.quartInOut.getF(prog - (x / hw)) * my) * ROOM_H).floor();
          ab.blitAlphaRect(buf1, cameraX + hw + x, 0, hw + x, scan, 1, ROOM_H - scan);
          ab.blitAlphaRect(buf1, cameraX + hw - x - 1, 0, hw - x - 1, scan, 1, ROOM_H - scan);
          ab.blitAlphaRect(buf2, cameraX + hw + x, ROOM_H - scan, hw + x, 0, 1, scan);
          ab.blitAlphaRect(buf2, cameraX + hw - x - 1, ROOM_H - scan, hw - x - 1, 0, 1, scan);
          /*
          // bubble transition
          var scan = (oy * ROOM_H + (Timing.quartInOut.getF(prog - (x / hw)) * my) * ROOM_H).floor();
          ab.blitAlphaRect(buf1, hw + x, 0, hw + x, scan, 1, ROOM_H - scan);
          ab.blitAlphaRect(buf1, hw - x - 1, 0, hw - x - 1, scan, 1, ROOM_H - scan);
          ab.blitAlphaRect(buf2, hw + x, 0, hw + x, 0, 1, scan);
          ab.blitAlphaRect(buf2, hw - x - 1, 0, hw - x - 1, 0, 1, scan);
          */
        }
      }
    }
  }
}
