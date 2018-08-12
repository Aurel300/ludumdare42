package lib;

import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;

using sk.thenet.FM;

class Ragdoll {
  public static function makeHumanoid(source:Bitmap, ox:Int, oy:Int):Ragdoll {
    var b = source.fluent;
    var ret = new Ragdoll();
    ret.root.yOffset = -24;
    if (source != null) ret.root.data = ["r" => new Turner(b >> new Cut(ox + 16, oy + 16, 16, 16))];
    ret.root.frame = "r";
    
    var head = ret.root.attach("head");
    head.yOffset = -9;
    if (source != null) head.data = ["r" => new Turner(b >> new Cut(ox + 16, oy, 16, 16))];
    head.frame = "r";
    
    var armR = ret.root.attach("armR");
    armR.xOffset = -6;
    armR.yOffset = -2;
    if (source != null) armR.data = ["r" => new Turner(b >> new Cut(ox, oy + 16, 16, 16))];
    armR.frame = "r";
    var handR = armR.attach("handR");
    handR.xOffset = 0;
    handR.yOffset = 8;
    if (source != null) handR.data = ["r" => new Turner(b >> new Cut(ox, oy + 32, 16, 16))];
    handR.frame = "r";
    
    var armL = ret.root.attach("armL");
    armL.xOffset = 6;
    armL.yOffset = -3;
    if (source != null) armL.data = ["r" => new Turner(b >> new Cut(ox, oy + 16, 16, 16))];
    armL.frame = "r";
    var handL = armL.attach("handL");
    handL.xOffset = 0;
    handL.yOffset = 8;
    if (source != null) handL.data = ["r" => new Turner(b >> new Cut(ox, oy + 32, 16, 16))];
    handL.frame = "r";
    
    var thighR = ret.root.attach("thighR");
    thighR.xOffset = -2;
    thighR.yOffset = 7;
    if (source != null) thighR.data = ["r" => new Turner(b >> new Cut(ox + 16, oy + 32, 32, 32))];
    thighR.frame = "r";
    var calfR = thighR.attach("calfR");
    calfR.xOffset = 1;
    calfR.yOffset = 10;
    if (source != null) calfR.data = ["r" => new Turner(b >> new Cut(ox + 48, oy + 32, 32, 32))];
    calfR.frame = "r";
    
    var thighL = ret.root.attach("thighL");
    thighL.xOffset = 2;
    thighL.yOffset = 7;
    if (source != null) thighL.data = ["r" => new Turner(b >> new Cut(ox + 16, oy + 32, 32, 32))];
    thighL.frame = "r";
    var calfL = thighL.attach("calfL");
    calfL.xOffset = 1;
    calfL.yOffset = 10;
    if (source != null) calfL.data = ["r" => new Turner(b >> new Cut(ox + 48, oy + 32, 32, 32))];
    calfL.frame = "r";
    
    return ret;
  }
  
  public var parts:Array<RdPart> = [];
  public var root:RdPart;
  public var partMap:Map<String, RdPart> = new Map();
  
  public function new() {
    root = new RdPart("root", this);
  }
  
  public function render(to:Bitmap, x:Int, y:Int, angle:Float):Void {
    root.render(to, x, y, angle);
  }
}

class RdPart {
  public var data:Map<String, Turner>;
  
  public var id:String;
  public var ragdoll:Ragdoll;
  public var angularOffset:Float = 0;
  public var xOffset:Float = 0;
  public var yOffset:Float = 0;
  public var frame:String;
  public var sub:Array<RdPart> = [];
  
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
  
  public function render(to:Bitmap, x:Float, y:Float, angle:Float):Void {
    var angleF = (angle / 180) * Math.PI;
    x += xOffset * Math.cos(angleF) - yOffset * Math.sin(angleF);
    y += xOffset * Math.sin(angleF) + yOffset * Math.cos(angleF);
    angle += angularOffset;
    if (data != null) {
      var b = data[frame].getAngle(angle);
      to.blitAlpha(b, (x - (b.width / 2)).floor(), (y - (b.height / 2)).floor());
    }
    for (s in sub) s.render(to, x, y, angle);
  }
}
