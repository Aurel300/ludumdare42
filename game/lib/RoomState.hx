package lib;

class RoomState {
  public var room:Room;
  
  public var objects:Array<RsObject>;
  public var player:RsObject;
  public var playerRd:Ragdoll;
  public var playerAq:AnimationQueue;
  
  public var enteredFrom:Direction;
  
  public var ragdolls:Map<String, Ragdoll> = new Map();
  public var interactive:Map<String, InteractiveState> = new Map();
  public var openExits:Array<Direction>;
  
  public var showTake:Bool = false;
  public var showGive:Bool = false;
  public var showOperation:Bool = false;
  
  public function new(room:Room) {
    this.room = room;
    objects = [ for (o in room.objects) switch (o) {
        case Ragdoll(name, anim, tileX, tileY, interactive):
        var rd = lib.Ragdoll.INDEX[name == "player" ? 'player${(room.x + room.y) % 2}' : name];
        ragdolls[name] = rd;
        Ragdoll(name, rd, new AnimationQueue(rd, anim, tileX, tileY), interactive);
        case _: continue;
      } ];
    interactive = [ for (i in room.interactives) i => new InteractiveState(Interactive.INDEX[i], this) ];
    for (i in room.interactives) {
      if (!Interactive.INDEX.exists(i)) trace("! no such interactive", i);
    }
    recalculate();
    objects.push({
        playerRd = lib.Ragdoll.INDEX['player${(room.x + room.y) % 2}'];
        playerAq = new AnimationQueue(playerRd, ["idleL", "idleR"], 0, 0);
        player = Ragdoll("player", playerRd, playerAq, null);
      });
    openExits = [ for (e in room.exits) if (e.open) e.pos ];
  }
  
  public function recalculate():Void {
    showTake = false;
    showGive = false;
    showOperation = false;
    for (i in interactive) {
      for (f in i.interactive.fragments) switch (f) {
        case Take(_): if (!i.solved[f]) { showTake = true; break; }
        case Give(_): if (!i.solved[f]) { showGive = true; break; }
        case Operation(_): showOperation = true;
        case _:
      }
    }
  }
  
  public function enter(from:Direction):Void {
    Story.inv.slots[RPos.xy(room.x, room.y)] = Map({x: room.x, y: room.y, explored: true});
    SGame.G.ui.updateInventory();
    Sfx.currentMusic = room.music;
    for (o in room.objects) switch (o) {
      case Exit(tileX, tileY, tileW, tileH, to, climbing):
      if (to != from) continue;
      switch (from) {
        case Top:
        playerAq.setXY(tileX + 1, -6);
        playerAq.enqueue([Fall], true);
        case Right:
        playerAq.setXY(RoomRenderer.ROOM_TILES_W + 3, tileY + tileH);
        playerAq.enqueue([WalkTo(RoomRenderer.ROOM_TILES_W - 3)], true);
        case Bottom:
        playerAq.setXY(tileX + 1, 2);
        playerAq.enqueue([ClimbTo(1)], true, "climbU");
        case Left:
        playerAq.setXY(-4, tileY + tileH);
        playerAq.enqueue([WalkTo(2)], true);
        case _:
      }
      enteredFrom = from;
      case _:
    }
  }
}

enum RsObject {
  Ragdoll(name:String, rd:Ragdoll, aq:AnimationQueue, interactive:Null<String>);
}
