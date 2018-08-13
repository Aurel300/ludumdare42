package lib;

using sk.thenet.FM;

class AnimationQueue {
  public var rd:Ragdoll;
  public var tileX:Int;
  public var tileY:Int;
  public var realY:Float;
  public var def:Array<String>;
  public var queue:Array<AnimationStep> = [];
  public var lastDef:String;
  
  public var rdam:lib.RagdollAnimation.RdAnimator;
  
  public var maxPos(get, never):Bool;
  private inline function get_maxPos():Bool {
    return rd.name == "climber" || ["climbU", "climbD", "falling"].indexOf(rdam.animation.name) == -1;
  }
  
  public function new(rd:Ragdoll, def:Array<String>, tx:Int, ty:Int) {
    this.rd = rd;
    this.def = def;
    setXY(tx, ty);
    var rda = RagdollAnimation.INDEX[def[0]];
    lastDef = def[0];
    rda.apply(rda.sequence[0], rd);
    rdam = rda.animate(rd);
    if (rd.name == "chef") {
      realY -= 12.5;
    }
  }
  
  public function setXY(tx:Int, ty:Int):Void {
    this.tileX = tx;
    this.tileY = ty;
    this.realY = 0;
  }
  
  public function apply(name:String):Void {
    var rda = RagdollAnimation.INDEX[name];
    rda.apply(rda.sequence[0], rd);
  }
  
  function startDefault():Void {
    var lastAnim = rdam.animation.name;
    if (lastAnim.charAt(lastAnim.length - 1) == "L") {
      lastDef = def[0];
    } else if (lastAnim.charAt(lastAnim.length - 1) == "R") {
      lastDef = def[1];
    }
    rdam = RagdollAnimation.INDEX[lastDef].animate(rd);
  }
  
  public function enqueue(anims:Array<AnimationStep>, ?interrupt:Bool = false, ?startAnim:String):Void {
    if (interrupt) {
      if (startAnim != null) apply(startAnim);
      queue = anims;
    } else {
      if (queue.length > 0) switch (queue[0]) {
        case WalkTo(px): queue = [WalkFinish].concat(anims); return;
        case _:
      }
      queue = queue.concat(anims);
    }
    handleQueue();
  }
  
  function handleQueue():Void {
    while (queue.length > 0) switch (queue[0]) {
      case Fall:
      if (tileY >= 0) {
        lastDef = def[1];
        queue.shift();
      } else {
        rdam = RagdollAnimation.INDEX["falling"].animate(rd); break;
      }
      case WalkFinish: queue.shift();
      case WalkTo(tx):
      if (tileX == tx) {
        queue.shift();
      } else {
        rdam = RagdollAnimation.INDEX[tileX < tx ? "walkR" : "walkL"].makeScaled(0.2).animate(rd); break;
      }
      case SlipTo(tx):
      if (tileX == tx) {
        queue.shift();
      } else {
        rdam = RagdollAnimation.INDEX[tileX < tx ? "slipR" : "slipL"].makeScaled(0.2).animate(rd); break;
      }
      case ClimbTo(ty):
      if (tileY == ty) {
        queue.shift();
      } else {
        rdam = RagdollAnimation.INDEX[tileY < ty ? "climbD" : "climbU"].animate(rd); break;
      }
      case Animation(name): rdam = RagdollAnimation.INDEX[name].animate(rd); queue.shift(); break;
      case Function(f): f(); queue.shift();
    }
    if (queue.length == 0) startDefault();
  }
  
  public function tick():Void {
    rdam.tick((frame, frozen) -> {
        for (part in frozen) if (part.id == "root") {
          if (part.xOffset >= RagdollAnimation.WALKSPEED) {
            part.xOffset -= RagdollAnimation.WALKSPEED;
            tileX++;
            rd.root.xOffset -= RagdollAnimation.WALKSPEED;
            break;
          }
          if (part.xOffset <= -RagdollAnimation.WALKSPEED) {
            part.xOffset += RagdollAnimation.WALKSPEED;
            tileX--;
            rd.root.xOffset += RagdollAnimation.WALKSPEED;
            break;
          }
          if (rd.name == "climber") {
            if ((part.yOffset + RagdollAnimation.CLIMBHEIGHT) <= -RagdollAnimation.CLIMBSPEED) {  
              part.yOffset += RagdollAnimation.CLIMBSPEED * 2;
              rd.root.yOffset += RagdollAnimation.CLIMBSPEED * 2;
              break;
            }
          } else if (rdam.animation.name == "climbU" || rdam.animation.name == "climbD") {
            if ((part.yOffset + RagdollAnimation.CLIMBHEIGHT) >= RagdollAnimation.CLIMBSPEED) {
              part.yOffset -= RagdollAnimation.CLIMBSPEED * 2;
              realY += RagdollAnimation.CLIMBSPEED * 2;
              rd.root.yOffset -= RagdollAnimation.CLIMBSPEED * 2;
              break;
            }
            if ((part.yOffset + RagdollAnimation.CLIMBHEIGHT) <= -RagdollAnimation.CLIMBSPEED) {
              part.yOffset += RagdollAnimation.CLIMBSPEED * 2;
              realY -= RagdollAnimation.CLIMBSPEED * 2;
              rd.root.yOffset += RagdollAnimation.CLIMBSPEED * 2;
              break;
            }
            if (realY >= RoomRenderer.TILE_H) {
              realY -= RoomRenderer.TILE_H;
              tileY++;
            }
            if (realY <= -RoomRenderer.TILE_H) {
              realY += RoomRenderer.TILE_H;
              tileY--;
            }
          }
          if (rdam.animation.name == "falling") {
            if ((part.yOffset + RagdollAnimation.FALLHEIGHT) >= RagdollAnimation.FALLSPEED) {
              part.yOffset -= RagdollAnimation.FALLSPEED * 2;
              tileY += 2;
              rd.root.yOffset -= RagdollAnimation.FALLSPEED * 2;
              break;
            }
          }
        }
        if (frame == 0) {
          if (rdam.animation.name == "walkL" || rdam.animation.name == "walkR") {
            Sfx.play("walk", .3);
          } else if (rdam.animation.name == "climbU" || rdam.animation.name == "climbD") {
            Sfx.play("climb", .3);
          }
          handleQueue();
        }
      });
  }
}

enum AnimationStep {
  Fall;
  WalkTo(tileX:Int);
  SlipTo(tileX:Int);
  WalkFinish;
  ClimbTo(tileY:Int);
  Animation(name:String);
  Function(f:Void->Void);
}
