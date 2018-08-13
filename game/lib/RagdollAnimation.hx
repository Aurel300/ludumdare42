package lib;

import sk.thenet.anim.*;

using sk.thenet.FM;

class RagdollAnimation {
  public static var WALKSPEED = 20;
  public static var CLIMBSPEED = 8;
  public static var STANDHEIGHT = 26;
  public static var CLIMBHEIGHT = 26;
  
  public static var FALLSPEED = 25;
  public static var FALLHEIGHT = 26;
  
  static function subWalk(rd:Ragdoll, a:String, b:String, walkOff:Int, right:Bool):Array<Array<RdaPart>> {
    var mul = right ? 1 : -1;
    return [
        {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = -1 * mul;
          rd.partMap["head"].angularOffset = 1 * mul;
          rd.partMap["root"].xOffset = (WALKSPEED / 6) * (1 + walkOff) * mul;
          rd.partMap["root"].yOffset = -1 - STANDHEIGHT;
          rd.partMap["arm" + a].angularOffset = -12.5 * mul;
          rd.partMap["hand" + a].angularOffset = -10 * mul;
          rd.partMap["thigh" + b].angularOffset = -22.5 * mul;
          rd.partMap["calf" + b].angularOffset = 0 * mul;
          rd.partMap["arm" + b].angularOffset = 15 * mul;
          rd.partMap["hand" + b].angularOffset = -10 * mul;
          rd.partMap["thigh" + a].angularOffset = 15 * mul;
          rd.partMap["calf" + a].angularOffset = 22.5 * mul;
          RagdollAnimation.freezeFrame(rd);
        }, {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = 0 * mul;
          rd.partMap["head"].angularOffset = 0 * mul;
          rd.partMap["root"].xOffset = (WALKSPEED / 6) * (2 + walkOff) * mul;
          rd.partMap["root"].yOffset = -3 - STANDHEIGHT;
          rd.partMap["arm" + a].angularOffset = -20 * mul;
          rd.partMap["hand" + a].angularOffset = -10 * mul;
          rd.partMap["thigh" + b].angularOffset = -20 * mul;
          rd.partMap["calf" + b].angularOffset = 22.5 * mul;
          rd.partMap["arm" + b].angularOffset = 5 * mul;
          rd.partMap["hand" + b].angularOffset = -10 * mul;
          rd.partMap["thigh" + a].angularOffset = 12 * mul;
          rd.partMap["calf" + a].angularOffset = 20 * mul;
          RagdollAnimation.freezeFrame(rd);
        }, {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = 2 * mul;
          rd.partMap["head"].angularOffset = 0 * mul;
          rd.partMap["root"].xOffset = (WALKSPEED / 6) * (3 + walkOff) * mul;
          rd.partMap["root"].yOffset = -4 - STANDHEIGHT;
          rd.partMap["arm" + a].angularOffset = -10 * mul;
          rd.partMap["hand" + a].angularOffset = -10 * mul;
          rd.partMap["thigh" + b].angularOffset = -10 * mul;
          rd.partMap["calf" + b].angularOffset = 10 * mul;
          rd.partMap["arm" + b].angularOffset = -20 * mul;
          rd.partMap["hand" + b].angularOffset = -10 * mul;
          rd.partMap["thigh" + a].angularOffset = -30 * mul;
          rd.partMap["calf" + a].angularOffset = 30 * mul;
          RagdollAnimation.freezeFrame(rd);
        }
      ];
  }
  
  static function subSlip(rd:Ragdoll, a:String, b:String, walkOff:Int, right:Bool):Array<Array<RdaPart>> {
    var mul = right ? 1 : -1;
    return [
        {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = -1 * mul;
          rd.partMap["head"].angularOffset = 1 * mul;
          rd.partMap["root"].xOffset = (WALKSPEED / 4) * (1 + walkOff) * mul;
          
          rd.partMap["arm" + a].angularOffset = 30 * mul;
          rd.partMap["hand" + a].angularOffset = -30 * mul;
          rd.partMap["thigh" + a].angularOffset = -10 * mul;
          rd.partMap["calf" + a].angularOffset = 30 * mul;
          
          rd.partMap["thigh" + b].angularOffset = -22.5 * mul;
          rd.partMap["calf" + b].angularOffset = 0 * mul;
          rd.partMap["arm" + b].angularOffset = 15 * mul;
          rd.partMap["hand" + b].angularOffset = -10 * mul;
          RagdollAnimation.freezeFrame(rd);
        }, {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = 2 * mul;
          rd.partMap["head"].angularOffset = 0 * mul;
          rd.partMap["root"].xOffset = (WALKSPEED / 4) * (2 + walkOff) * mul;
          
          rd.partMap["arm" + a].angularOffset = 25 * mul;
          rd.partMap["hand" + a].angularOffset = -30 * mul;
          rd.partMap["thigh" + a].angularOffset = -10 * mul;
          rd.partMap["calf" + a].angularOffset = 30 * mul;
          
          rd.partMap["thigh" + b].angularOffset = -30.5 * mul;
          rd.partMap["calf" + b].angularOffset = 0 * mul;
          rd.partMap["arm" + b].angularOffset = 15 * mul;
          rd.partMap["hand" + b].angularOffset = -10 * mul;
          RagdollAnimation.freezeFrame(rd);
        }
      ];
  }
  
  static function subIdle(rd:Ragdoll, a:String, b:String, right:Bool, ?human:Bool = false):Array<Array<RdaPart>> {
    var mul = right ? 1 : -1;
    return [
        {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = 0;
          rd.partMap["head"].angularOffset = 0;
          rd.partMap["head"].yOffset = -10;
          rd.partMap["root"].xOffset = 0;
          rd.partMap["root"].yOffset = -1 - STANDHEIGHT;
          
          rd.partMap["arm" + a].angularOffset = 5 * mul;
          rd.partMap["hand" + a].angularOffset = -30 * mul;
          rd.partMap["thigh" + a].angularOffset = -10 * mul;
          rd.partMap["calf" + a].angularOffset = human ? 0 : 30 * mul;
          
          rd.partMap["arm" + b].angularOffset = 5 * mul;
          rd.partMap["hand" + b].angularOffset = -30 * mul;
          rd.partMap["thigh" + b].angularOffset = 10 * mul;
          rd.partMap["calf" + b].angularOffset = (human ? -10 : 10) * mul;
          
          RagdollAnimation.freezeFrame(rd);
        }, {
          rd.setAllFrames(right ? "r" : "l");
          rd.reorderHumanoid(right);
          rd.partMap["root"].angularOffset = 0;
          rd.partMap["head"].angularOffset = 0;
          rd.partMap["head"].yOffset = -8;
          rd.partMap["root"].xOffset = 0;
          rd.partMap["root"].yOffset = -1 - STANDHEIGHT;
          
          rd.partMap["arm" + a].angularOffset = 5 * mul;
          rd.partMap["hand" + a].angularOffset = -30 * mul;
          rd.partMap["thigh" + a].angularOffset = -10 * mul;
          rd.partMap["calf" + a].angularOffset = human ? 0 : 30 * mul;
          
          rd.partMap["arm" + b].angularOffset = 5 * mul;
          rd.partMap["hand" + b].angularOffset = -30 * mul;
          rd.partMap["thigh" + b].angularOffset = 10 * mul;
          rd.partMap["calf" + b].angularOffset = (human ? -10 : 10) * mul;
          
          RagdollAnimation.freezeFrame(rd);
        }
      ];
  }
  
  static function subClimb(rd:Ragdoll, a:String, b:String, mul:Int, dir:Float):Array<RdaPart> {
    rd.setAllFrames("back");
    rd.reorderHumanoid(true);
    
    //rd.partMap["root"].angularOffset = -10 * dir;
    rd.partMap["head"].angularOffset = -10 * dir;
    rd.partMap["root"].yOffset = -CLIMBHEIGHT + CLIMBSPEED * mul;
    
    rd.partMap["arm" + a].angularOffset = -170 * dir;
    rd.partMap["hand" + a].angularOffset = -20 * dir;
    rd.partMap["thigh" + a].angularOffset = -10 * dir;
    rd.partMap["calf" + a].angularOffset = 30 * dir;
    
    rd.partMap["arm" + b].angularOffset = 90 * dir;
    rd.partMap["hand" + b].angularOffset = 110 * dir;
    rd.partMap["thigh" + b].angularOffset = 80 * dir;
    rd.partMap["calf" + b].angularOffset = -90 * dir;
    return RagdollAnimation.freezeFrame(rd);
  }
  
  static function subFall(rd:Ragdoll, mul:Int):Array<RdaPart> {
    rd.setAllFrames("r");
    rd.reorderHumanoid(true);
    
    rd.partMap["head"].angularOffset = -10;
    rd.partMap["root"].yOffset = -FALLHEIGHT + FALLSPEED * mul;
    
    rd.partMap["armL"].angularOffset = -170;
    rd.partMap["handL"].angularOffset = -20;
    rd.partMap["thighL"].angularOffset = -10;
    rd.partMap["calfL"].angularOffset = 30;
    
    rd.partMap["armR"].angularOffset = 90;
    rd.partMap["handR"].angularOffset = 110;
    rd.partMap["thighR"].angularOffset = 10;
    rd.partMap["calfR"].angularOffset = -20;
    return RagdollAnimation.freezeFrame(rd);
  }
  
  static function subSit(rd:Ragdoll, a:String, b:String, right:Bool, dir:Float):Array<RdaPart> {
    rd.setAllFrames(right ? "r" : "l");
    rd.reorderHumanoid(right);
    
    rd.partMap["root"].yOffset = 0;
    
    rd.partMap["arm" + a].angularOffset = -35 * dir;
    rd.partMap["hand" + a].angularOffset = -55 * dir;
    rd.partMap["thigh" + a].angularOffset = -70 * dir;
    rd.partMap["calf" + a].angularOffset = 90 * dir;
    
    rd.partMap["arm" + b].angularOffset = 35 * dir;
    rd.partMap["hand" + b].angularOffset = -145 * dir;
    rd.partMap["thigh" + b].angularOffset = -70 * dir;
    rd.partMap["calf" + b].angularOffset = 90 * dir;
    return RagdollAnimation.freezeFrame(rd);
  }
  
  public static var INDEX:Map<String, RagdollAnimation> = [
      "walkR" => new RagdollAnimation("walkR", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subWalk(rd, "L", "R", 0, true).concat(subWalk(rd, "R", "L", 3, true));
        }, [0, 1, 2, 3, 4, 5], [20, 15, 20, 20, 15, 20])
      ,"walkL" => new RagdollAnimation("walkL", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subWalk(rd, "R", "L", 0, false).concat(subWalk(rd, "L", "R", 3, false));
        }, [0, 1, 2, 3, 4, 5], [20, 15, 20, 20, 15, 20])
      ,"slipR" => new RagdollAnimation("slipR", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subSlip(rd, "L", "R", 0, true).concat(subSlip(rd, "R", "L", 2, true));
        }, [0, 1, 2, 3], [12, 12, 12, 12])
      ,"slipL" => new RagdollAnimation("slipL", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subSlip(rd, "R", "L", 0, false).concat(subSlip(rd, "L", "R", 2, false));
        }, [0, 1, 2, 3], [12, 12, 12, 12])
      ,"idleR" => new RagdollAnimation("idleR", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subIdle(rd, "L", "R", true);
        }, [0, 1], [50, 50])
      ,"idleL" => new RagdollAnimation("idleL", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subIdle(rd, "R", "L", false);
        }, [0, 1], [50, 50])
      ,"idleHumanR" => new RagdollAnimation("idleHumanR", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subIdle(rd, "L", "R", true, true);
        }, [0, 1], [50, 50])
      ,"idleHumanL" => new RagdollAnimation("idleHumanL", {
          var rd = Ragdoll.makeHumanoid("", 0);
          subIdle(rd, "R", "L", false, true);
        }, [0, 1], [50, 50])
      ,"climbD" => (new RagdollAnimation("climbD", {
          var rd = Ragdoll.makeHumanoid("", 0);
          [subClimb(rd, "L", "R", 0, 1), subClimb(rd, "R", "L", 1, -1)];
        }, [0, 1], [40, 40], (_, f) -> Timing.quadInOut.getF(f))).makeScaled(.5)
      ,"climbU" => new RagdollAnimation("climbU", {
          var rd = Ragdoll.makeHumanoid("", 0);
          [subClimb(rd, "L", "R", 0, 1), subClimb(rd, "R", "L", -1, -1)];
        }, [0, 1], [40, 40], (_, f) -> Timing.quadInOut.getF(f))
      ,"sitR" => new RagdollAnimation("sitR", {
          var rd = Ragdoll.makeHumanoid("", 0);
          [subSit(rd, "L", "R", true, 1)];
        }, [0], [40])
      ,"sitL" => new RagdollAnimation("sitL", {
          var rd = Ragdoll.makeHumanoid("", 0);
          [subSit(rd, "R", "L", false, -1)];
        }, [0], [40])
      ,"falling" => new RagdollAnimation("falling", {
          var rd = Ragdoll.makeHumanoid("", 0);
          [subFall(rd, 0), subFall(rd, 1)];
        }, [0, 1], [10, 10])
    ];
  
  public static function freezeFrame(ragdoll:Ragdoll):Array<RdaPart> {
    return [ for (p in ragdoll.parts) {
         id: p.id
        ,xOffset: p.xOffset
        ,yOffset: p.yOffset
        ,angularOffset: p.angularOffset
        ,frame: p.frame
        ,zOrder: p.zOrder
      } ];
  }
  
  public var frames:Array<Array<RdaPart>> = [];
  public var sequence:Array<Int>;
  public var lengths:Array<Int>;
  public var name:String;
  
  public var prog:String->Float->Float = (_, f) -> Timing.linear.getF(f);
  
  public function new(name:String, frames:Array<Array<RdaPart>>, s:Array<Int>, l:Array<Int>, ?p:String->Float->Float) {
    this.name = name;
    this.frames = frames;
    this.sequence = s;
    this.lengths = l;
    if (p != null) this.prog = p;
  }
  
  public function apply(frame:Int, ragdoll:Ragdoll):Void {
    for (part in frames[frame]) {
      var rdPart = ragdoll.partMap[part.id];
      rdPart.xOffset = part.xOffset;
      rdPart.yOffset = part.yOffset;
      rdPart.angularOffset = part.angularOffset;
      rdPart.frame = part.frame;
      rdPart.zOrder = part.zOrder;
    }
  }
  
  public function animate(ragdoll:Ragdoll):RdAnimator {
    return new RdAnimator(ragdoll, this);
  }
  
  public function lerp(from:Array<RdaPart>, frame:Int, ragdoll:Ragdoll, pos:Float):Void {
    var i = 0;
    var fromMap = [ for (p in from) p.id => p ];
    for (part in frames[frame]) {
      var prevPart = fromMap[part.id];
      var rdPart = ragdoll.partMap[part.id];
      var partProg = prog(part.id, pos);
      rdPart.xOffset = prevPart.xOffset * (1 - partProg) + part.xOffset * partProg;
      rdPart.yOffset = prevPart.yOffset * (1 - partProg) + part.yOffset * partProg;
      rdPart.angularOffset = prevPart.angularOffset * (1 - partProg) + part.angularOffset * partProg;
      rdPart.frame = partProg >= .5 ? part.frame : prevPart.frame;
      rdPart.zOrder = partProg >= .5 ? part.zOrder : prevPart.zOrder;
    }
  }
  
  public function makeScaled(scale:Float):RagdollAnimation {
    return new RagdollAnimation(name, frames, sequence, [ for (l in lengths) (l * scale).floor() ], prog);
  }
}

typedef RdaPart = {
     id:String
    ,xOffset:Float
    ,yOffset:Float
    ,zOrder:Int
    ,angularOffset:Float
    ,frame:String
  };

class RdAnimator {
  public var ragdoll:Ragdoll;
  public var animation:RagdollAnimation;
  
  public var sequenceLength:Int;
  public var pos:Int = 0;
  
  public var frozen:Array<RdaPart>;
  public var frozenFrame:Int = 0;
  public var lastFrame:Int = 0;
  
  public function new(ragdoll:Ragdoll, animation:RagdollAnimation) {
    this.ragdoll = ragdoll;
    this.animation = animation;
    
    sequenceLength = 0;
    for (s in animation.lengths) sequenceLength += s;
    
    frozen = RagdollAnimation.freezeFrame(ragdoll);
  }
  
  public function tick(onFreeze:Int->Array<RdaPart>->Void):Void {
    var frame = 0;
    var seqPos = 0;
    var seqLen = 0;
    var lastSeq = 0;
    do {
      lastSeq = seqLen;
      seqLen += animation.lengths[seqPos++];
    } while (seqLen < pos);
    seqPos--;
    var frame = animation.sequence[seqPos % animation.sequence.length];
    if (frame != lastFrame) {
      animation.apply(lastFrame, ragdoll);
      frozen = RagdollAnimation.freezeFrame(ragdoll);
      onFreeze(frame, frozen);
      frozenFrame = lastFrame;
    }
    animation.lerp(frozen, frame, ragdoll, (pos - lastSeq) / animation.lengths[seqPos]);
    pos++;
    pos %= sequenceLength;
    lastFrame = frame;
  }
}
