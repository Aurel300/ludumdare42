package lib;

import sk.thenet.anim.*;

using sk.thenet.FM;

class RagdollAnimation {
  static var WALKSPEED = 20;
  
  static function subWalk(a:String, b:String, mul:Int):Array<Array<RdaPart>> {
    return ([
        [
           {id: "root", angularOffset: -1, xOffset: (WALKSPEED / 6) * (1 + mul), yOffset: -21}
          ,{id: "head", angularOffset: 2}
          ,{id: "arm" + a, angularOffset: -12.5}
          ,{id: "thigh" + b, angularOffset: -22.5}
          ,{id: "calf" + b, angularOffset: 0}
          ,{id: "arm" + b, angularOffset: 15}
          ,{id: "thigh" + a, angularOffset: 15}
          ,{id: "calf" + a, angularOffset: 22.5}
        ], [
           {id: "root", angularOffset: 0, xOffset: (WALKSPEED / 6) * (2 + mul), yOffset: -23}
          ,{id: "head", angularOffset: 0}
          ,{id: "arm" + a, angularOffset: -20}
          ,{id: "thigh" + b, angularOffset: -20}
          ,{id: "calf" + b, angularOffset: 22.5}
          ,{id: "arm" + b, angularOffset: 5}
          ,{id: "thigh" + a, angularOffset: 12}
          ,{id: "calf" + a, angularOffset: 20}
        ], [
           {id: "root", angularOffset: 2, xOffset: (WALKSPEED / 6) * (3 + mul), yOffset: -24}
          ,{id: "head", angularOffset: 4}
          ,{id: "arm" + a, angularOffset: -10}
          ,{id: "thigh" + b, angularOffset: -10}
          ,{id: "calf" + b, angularOffset: 10}
          ,{id: "arm" + b, angularOffset: -20}
          ,{id: "thigh" + a, angularOffset: -30}
          ,{id: "calf" + a, angularOffset: 30}
        ]
      ]:Array<Array<RdaPart>>);
  }
  
  public static var INDEX:Map<String, RagdollAnimation> = [
      "walkR" => new RagdollAnimation({
          var rd = Ragdoll.makeHumanoid(null, 0, 0);
          [
            {
              rd.partMap["root"].angularOffset = -1;
              rd.partMap["head"].angularOffset = 2;
              rd.partMap["root"].xOffset = WALKSPEED / 6;
              rd.partMap["root"].yOffset = -21;
              rd.partMap["armL"].angularOffset = -12.5;
              rd.partMap["thighR"].angularOffset = -22.5;
              rd.partMap["calfR"].angularOffset = 0;
              rd.partMap["armR"].angularOffset = 15;
              rd.partMap["thighL"].angularOffset = 15;
              rd.partMap["calfL"].angularOffset = 22.5;
              RagdollAnimation.freezeFrame(rd);
            },
            {
              rd.partMap["root"].angularOffset = 0;
              rd.partMap["head"].angularOffset = 0;
              rd.partMap["root"].xOffset = (WALKSPEED / 6) * 2;
              rd.partMap["root"].yOffset = -23;
              rd.partMap["armL"].angularOffset = -20;
              rd.partMap["thighR"].angularOffset = -20;
              rd.partMap["calfR"].angularOffset = 22.5;
              rd.partMap["armR"].angularOffset = 5;
              rd.partMap["thighL"].angularOffset = 12;
              rd.partMap["calfL"].angularOffset = 20;
              RagdollAnimation.freezeFrame(rd);
            },
            {
              rd.partMap["root"].angularOffset = 2;
              rd.partMap["head"].angularOffset = 4;
              rd.partMap["root"].xOffset = (WALKSPEED / 6) * 3;
              rd.partMap["root"].yOffset = -24;
              rd.partMap["armL"].angularOffset = -10;
              rd.partMap["thighR"].angularOffset = -10;
              rd.partMap["calfR"].angularOffset = 10;
              rd.partMap["armR"].angularOffset = -20;
              rd.partMap["thighL"].angularOffset = -30;
              rd.partMap["calfL"].angularOffset = 30;
              RagdollAnimation.freezeFrame(rd);
            },
            {
              rd.partMap["root"].angularOffset = 2;
              rd.partMap["head"].angularOffset = 2;
              rd.partMap["root"].xOffset = (WALKSPEED / 6) * 4;
              rd.partMap["root"].yOffset = -21;
              rd.partMap["armR"].angularOffset = -12.5;
              rd.partMap["thighL"].angularOffset = -22.5;
              rd.partMap["calfL"].angularOffset = 0;
              rd.partMap["armL"].angularOffset = 15;
              rd.partMap["thighR"].angularOffset = 15;
              rd.partMap["calfR"].angularOffset = 22.5;
              RagdollAnimation.freezeFrame(rd);
            },
            {
              rd.partMap["root"].angularOffset = 0;
              rd.partMap["head"].angularOffset = 0;
              rd.partMap["root"].xOffset = (WALKSPEED / 6) * 5;
              rd.partMap["root"].yOffset = -23;
              rd.partMap["armR"].angularOffset = -20;
              rd.partMap["thighL"].angularOffset = -20;
              rd.partMap["calfL"].angularOffset = 22.5;
              rd.partMap["armL"].angularOffset = 5;
              rd.partMap["thighR"].angularOffset = 12;
              rd.partMap["calfR"].angularOffset = 20;
              RagdollAnimation.freezeFrame(rd);
            },
            {
              rd.partMap["root"].angularOffset = -1;
              rd.partMap["head"].angularOffset = 2;
              rd.partMap["root"].xOffset = (WALKSPEED / 6) * 6;
              rd.partMap["root"].yOffset = -24;
              rd.partMap["armR"].angularOffset = -10;
              rd.partMap["thighL"].angularOffset = -10;
              rd.partMap["calfL"].angularOffset = 10;
              rd.partMap["armL"].angularOffset = -20;
              rd.partMap["thighR"].angularOffset = -30;
              rd.partMap["calfR"].angularOffset = 30;
              RagdollAnimation.freezeFrame(rd);
            }
          ];
        })
    ];
  
  public static function freezeFrame(ragdoll:Ragdoll):Array<RdaPart> {
    return [ for (p in ragdoll.parts) {
        var r:RdaPart = {id: p.id};
        r.xOffset = p.xOffset;
        r.yOffset = p.yOffset;
        r.angularOffset = p.angularOffset;
        r.frame = p.frame;
        r;
      } ];
  }
  
  public var frames:Array<Array<RdaPart>> = [];
  
  public function new(frames:Array<Array<RdaPart>>) {
    this.frames = frames;
  }
  
  public function apply(frame:Int, ragdoll:Ragdoll):Void {
    for (part in frames[frame]) {
      var rdPart = ragdoll.partMap[part.id];
      if (part.xOffset != null) rdPart.xOffset = part.xOffset;
      if (part.yOffset != null) rdPart.yOffset = part.yOffset;
      if (part.angularOffset != null) rdPart.angularOffset = part.angularOffset;
      //if (part.frame != null) rdPart.frame = part.frame;
    }
  }
  
  public function animate(sequence:Array<Int>, lengths:Array<Int>, ragdoll:Ragdoll):RdAnimator {
    return new RdAnimator(ragdoll, this, sequence, lengths);
  }
  
  public function lerp(from:Array<RdaPart>, frame:Int, ragdoll:Ragdoll, prog:String->Float):Void {
    var i = 0;
    for (part in frames[frame]) {
      var prevPart = from[i++];
      var rdPart = ragdoll.partMap[part.id];
      var partProg = prog(part.id);
      //inline function fix(cur:Float, prev:Null<Float>, target:Null<Float>):Float {
      //  //prev = (prev == null ? 0 : prev);
      //  //target = (target == null ? 0 : target);
      //  return target != null
      //    ? ((prev == null ? cur : prev) * (1 - partProg) + target * partProg)
      //    : cur;
      //}
      //rdPart.xOffset = fix(rdPart.xOffset, prevPart.xOffset, part.xOffset);
      //rdPart.yOffset = fix(rdPart.yOffset, prevPart.yOffset, part.yOffset);
      //rdPart.angularOffset = fix(rdPart.angularOffset, prevPart.angularOffset, part.angularOffset);
      if (part.xOffset != null) rdPart.xOffset = prevPart.xOffset * (1 - partProg) + part.xOffset * partProg;
      if (part.yOffset != null) rdPart.yOffset = prevPart.yOffset * (1 - partProg) + part.yOffset * partProg;
      if (part.angularOffset != null) rdPart.angularOffset = prevPart.angularOffset * (1 - partProg) + part.angularOffset * partProg;
      //if (part.frame != null) rdPart.frame = partProg >= .5 ? part.frame : prevPart.frame;
    }
  }
}

typedef RdaPart = {
     id:String
    ,?xOffset:Float
    ,?yOffset:Float
    ,?angularOffset:Float
    ,?frame:String
  };

class RdAnimator {
  public var ragdoll:Ragdoll;
  public var animation:RagdollAnimation;
  public var sequence:Array<Int>;
  public var lengths:Array<Int>;
  
  public var sequenceLength:Int;
  public var pos:Int = 0;
  
  public var frozen:Array<RdaPart>;
  public var frozenFrame:Int = 0;
  public var lastFrame:Int = 0;
  
  public function new(ragdoll:Ragdoll, animation:RagdollAnimation, sequence:Array<Int>, lengths:Array<Int>) {
    this.ragdoll = ragdoll;
    this.animation = animation;
    this.sequence = sequence;
    this.lengths = lengths;
    
    sequenceLength = 0;
    for (s in lengths) sequenceLength += s;
    
    frozen = RagdollAnimation.freezeFrame(ragdoll);
  }
  
  public function makeScaled(scale:Float):RdAnimator {
    return new RdAnimator(ragdoll, animation, sequence, [ for (l in lengths) (l * scale).floor() ]);
  }
  
  public function tick(onFreeze:Array<RdaPart>->Void):Void {
    var frame = 0;
    var seqPos = 0;
    var seqLen = 0;
    var lastSeq = 0;
    do {
      lastSeq = seqLen;
      seqLen += lengths[seqPos++];
    } while (seqLen < pos);
    seqPos--;
    var frame = sequence[seqPos % sequence.length];
    if (frame != lastFrame) {
      animation.apply(lastFrame, ragdoll);
      frozen = RagdollAnimation.freezeFrame(ragdoll);
      onFreeze(frozen);
      frozenFrame = lastFrame;
    }
    animation.lerp(frozen, frame, ragdoll, _ -> Timing.linear.getF((pos - lastSeq) / lengths[seqPos]));
    pos++;
    pos %= sequenceLength;
    lastFrame = frame;
  }
}
