package lib;

import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;
import sk.thenet.plat.Platform;

using sk.thenet.FM;

class Ragdoll {
  public static var INDEX:Map<String, Ragdoll>;
  
  public static function init(amB:String->Bitmap):Void {
    var b = amB("ragdolls");
    INDEX = [
        "player0" => Ragdoll.makeHumanoid("player", Pal.P[0])
          .addHumanoidFrame("r", b, 64, 0)
          .addHumanoidFrame("l", b, 64, 0, false, true)
          .addHumanoidFrame("back", b, 64, 64)
        ,"player1" => Ragdoll.makeHumanoid("player", Pal.P[0])
          .addHumanoidFrame("r", b, 64, 0)
          .addHumanoidFrame("l", b, 64, 0, false, true)
          .addHumanoidFrame("back", b, 64, 64)
        ,"climber" => Ragdoll.makeHumanoid("climber", Pal.P[3])
          .addHumanoidFrame("back", b, 64, 64)
        ,"ss" => Ragdoll.makeHumanoid("ss", Pal.P[8])
          .addHumanoidFrame("r", b, 128, 0)
          .addHumanoidFrame("l", b, 128, 0, false, true)
        ,"king" => Ragdoll.makeHumanoid("king", Pal.P[5 + 18 * 2])
          .addHumanoidFrame("r", b, 192, 0)
          .addHumanoidFrame("l", b, 192, 0, false, true)
        ,"guard" => Ragdoll.makeHumanoid("guard", Pal.P[5 + 18 * 2])
          .addHumanoidFrame("r", b, 256, 0, true)
          .addHumanoidFrame("l", b, 256, 0, true, true)
        ,"queen" => Ragdoll.makeHumanoid("queen", Pal.P[5 + 18 * 2])
          .addHumanoidFrame("r", b, 0, 64)
          .addHumanoidFrame("l", b, 0, 64, false, true)
        ,"hey" => Ragdoll.makeHumanoid("hey", Pal.P[1])
          .addHumanoidFrame("r", b, 128, 64)
          .addHumanoidFrame("l", b, 128, 64, false, true)
        ,"rap" => Ragdoll.makeHumanoid("rap", Pal.P[10 + 18 * 2])
          .addHumanoidFrame("r", b, 192, 64)
          .addHumanoidFrame("l", b, 192, 64, false, true)
        ,"actor" => Ragdoll.makeHumanoid("actor", Pal.P[3])
          .addHumanoidFrame("r", b, 0, 128)
          .addHumanoidFrame("l", b, 0, 128, false, true)
        ,"checker" => Ragdoll.makeHumanoid("checker", Pal.P[3 + 18])
          .addHumanoidFrame("r", b, 64, 128)
          .addHumanoidFrame("l", b, 64, 128, false, true)
        ,"general" => Ragdoll.makeHumanoid("general", Pal.P[4])
          .addHumanoidFrame("r", b, 128, 128)
          .addHumanoidFrame("l", b, 128, 128, false, true)
        ,"1dec*3" => Ragdoll.makeHumanoid("1dec*3", Pal.P[4 + 18])
          .addHumanoidFrame("r", b, 192, 128)
          .addHumanoidFrame("l", b, 192, 128, false, true)
        ,"1inc" => Ragdoll.makeHumanoid("1inc", Pal.P[8 + 18])
          .addHumanoidFrame("r", b, 256, 128)
          .addHumanoidFrame("l", b, 256, 128, false, true)
        ,"juggler" => Ragdoll.makeHumanoid("juggler", Pal.P[4 + 18])
          .addHumanoidFrame("r", b, 320, 128)
          .addHumanoidFrame("l", b, 320, 128, false, true)
        ,"bouncer" => Ragdoll.makeHumanoid("bouncer", Pal.P[17])
          .addHumanoidFrame("r", b, 0, 192)
          .addHumanoidFrame("l", b, 0, 192, false, true)
        ,"chef" => Ragdoll.makeHumanoid("chef", Pal.P[21])
          .addHumanoidFrame("r", b, 64, 192)
          .addHumanoidFrame("l", b, 64, 192, false, true)
        ,"pirate" => Ragdoll.makeHumanoid("pirate", Pal.P[9])
          .addHumanoidFrame("r", b, 128, 192)
          .addHumanoidFrame("l", b, 128, 192, false, true)
        ,"g1" => Ragdoll.makeHumanoid("g1", Pal.P[14])
          .addHumanoidFrame("r", b, 192, 192)
          .addHumanoidFrame("l", b, 192, 192, false, true)
        ,"g2" => Ragdoll.makeHumanoid("g2", Pal.P[13])
          .addHumanoidFrame("r", b, 256, 192)
          .addHumanoidFrame("l", b, 256, 192, false, true)
        ,"g3" => Ragdoll.makeHumanoid("g3", Pal.P[12])
          .addHumanoidFrame("r", b, 320, 192)
          .addHumanoidFrame("l", b, 320, 192, false, true)
      ];
  }
  
  public static function makeHumanoid(name:String, c:Colour):Ragdoll {
    var ret = new Ragdoll(name, c);
    ret.root.yOffset = -24;
    
    var head = ret.root.attach("head");
    head.yOffset = -9;
    
    var armR = ret.root.attach("armR");
    armR.xOffset = -6;
    armR.yOffset = -2;
    var handR = armR.attach("handR");
    handR.xOffset = 0;
    handR.yOffset = 8;
    
    var armL = ret.root.attach("armL");
    armL.xOffset = 6;
    armL.yOffset = -3;
    var handL = armL.attach("handL");
    handL.xOffset = 0;
    handL.yOffset = 8;
    
    var thighR = ret.root.attach("thighR");
    thighR.xOffset = -2;
    thighR.yOffset = 7;
    var calfR = thighR.attach("calfR");
    calfR.xOffset = 1;
    calfR.yOffset = 10;
    var footR = calfR.attach("footR");
    footR.xOffset = 2;
    footR.yOffset = 10;
    
    var thighL = ret.root.attach("thighL");
    thighL.xOffset = 2;
    thighL.yOffset = 7;
    var calfL = thighL.attach("calfL");
    calfL.xOffset = 1;
    calfL.yOffset = 10;
    var footL = calfL.attach("footL");
    footL.xOffset = 2;
    footL.yOffset = 10;
    
    return ret;
  }
  
  public var name:String;
  public var parts:Array<RdPart> = [];
  public var root:RdPart;
  public var partMap:Map<String, RdPart> = new Map();
  public var colour:Colour;
  
  public var xMin:Int = 0;
  public var yMin:Int = 0;
  public var xMax:Int = 0;
  public var yMax:Int = 0;
  
  var glow:RagdollGlow;
  var buf:Bitmap;
  
  public function new(name:String, c:Colour) {
    this.name = name;
    colour = c;
    glow = new RagdollGlow(c);
    root = new RdPart("root", this);
    buf = Platform.createBitmap(80, 90, 0);
  }
  
  public function renderGlow(to:Bitmap, x:Int, y:Int, angle:Float, ?maxPos:Bool = false):Void {
    buf.fill(0);
    render(buf, 40, 65, angle);
    buf.fluent << glow;
    var tx = x - 40;
    var ty = y - 1 - (maxPos ? glow.yMax : 63);
    xMin = glow.xMin + tx;
    yMin = glow.yMin + ty;
    xMax = glow.xMax + tx;
    yMax = glow.yMax + ty;
    to.blitAlpha(buf, tx, ty);
  }
  
  public function render(to:Bitmap, x:Int, y:Int, angle:Float):Void {
    root.prerender(x, y, angle);
    parts.sort(sortParts);
    for (p in parts) {
      p.render(to);
    }
  }
  
  public function setAllFrames(frame:String):Void {
    for (p in parts) p.frame = frame;
  }
  
  public function reorderHumanoid(right:Bool):Void {
    var mul = right ? 1 : -1;
    root.zOrder = 0;
    partMap["head"].zOrder = 1;
    partMap["armR"].zOrder = 4 * mul;
    partMap["handR"].zOrder = 5 * mul;
    partMap["armL"].zOrder = -4 * mul;
    partMap["handL"].zOrder = -5 * mul;
    partMap["thighR"].zOrder = 2 * mul;
    partMap["calfR"].zOrder = 3 * mul;
    partMap["thighL"].zOrder = -2 * mul;
    partMap["calfL"].zOrder = -3 * mul;
  }
  
  public function addHumanoidFrame(frame:String, source:Bitmap, ox:Int, oy:Int, ?separateThighs:Bool = false, ?flip:Bool = false):Ragdoll {
    var b = source.fluent;
    
    function c(x:Int, y:Int, w:Int, h:Int):Bitmap {
      var ret = b >> new Cut(ox + x, oy + y, w, h);
      if (flip) ret = ret.fluent >> new Flip();
      return ret;
    }
    
    var sa = flip ? "R" : "L";
    var sb = flip ? "L" : "R";
    
    root.data[frame] = new Turner(c(16, 16, 16, 16));
    root.frame = frame;
    
    var head = partMap["head"];
    head.data[frame] = new Turner(c(16, 0, 16, 16));
    head.frame = frame;
    
    var armR = partMap["arm" + sb];
    armR.data[frame] = new Turner(c(0, 0, 16, 16));
    armR.frame = frame;
    
    var handR = partMap["hand" + sb];
    handR.data[frame] = new Turner(c(0, 16, 16, 16));
    handR.frame = frame;
    
    var armL = partMap["arm" + sa];
    armL.data[frame] = new Turner(c(32, 0, 16, 16));
    armL.frame = frame;
    
    var handL = partMap["hand" + sa];
    handL.data[frame] = new Turner(c(32, 16, 16, 16));
    handL.frame = frame;
    
    var thighR = partMap["thigh" + sb];
    thighR.data[frame] = new Turner(c(0, 32, 32, 32));
    thighR.frame = frame;
    
    var calfR = partMap["calf" + sb];
    calfR.data[frame] = new Turner(c(32, 32, 32, 32));
    calfR.frame = frame;
    
    var thighL = partMap["thigh" + sa];
    thighL.data[frame] = new Turner(c(0, 32 + (separateThighs ? 32 : 0), 32, 32));
    thighL.frame = frame;
    
    var calfL = partMap["calf" + sa];
    calfL.data[frame] = new Turner(c(32, 32, 32, 32));
    calfL.frame = frame;
    
    return this;
  }
  
  inline function sortParts(a:RdPart, b:RdPart):Int return a.zOrder - b.zOrder;
}

class RdPart {
  public var data:Map<String, Turner> = new Map();
  
  public var id:String;
  public var ragdoll:Ragdoll;
  public var angularOffset:Float = 0;
  public var xOffset:Float = 0;
  public var yOffset:Float = 0;
  public var frame:String = "";
  public var zOrder:Int = 0;
  public var sub:Array<RdPart> = [];
  
  public var _x:Float = 0;
  public var _y:Float = 0;
  public var _angle:Float = 0;
  
  public function new(id:String, ragdoll:Ragdoll) {
    this.id = id;
    this.ragdoll = ragdoll;
    ragdoll.parts.push(this);
    ragdoll.partMap[id] = this;
  }
  
  public function attach(id:String):RdPart {
    var ret = new RdPart(id, ragdoll);
    sub.push(ret);
    return ret;
  }
  
  public function prerender(x:Float, y:Float, angle:Float):Void {
    var angleF = (angle / 180) * Math.PI;
    x += xOffset * Math.cos(angleF) - yOffset * Math.sin(angleF);
    y += xOffset * Math.sin(angleF) + yOffset * Math.cos(angleF);
    angle += angularOffset;
    _x = x;
    _y = y;
    _angle = angle;
    for (s in sub) s.prerender(x, y, angle);
  }
  
  public function render(to:Bitmap):Void {
    if (data.exists(frame)) {
      var b = data[frame].getAngle(_angle);
      to.blitAlpha(b, (_x - (b.width / 2)).round(), (_y - (b.height / 2)).round());
    }
  }
}
