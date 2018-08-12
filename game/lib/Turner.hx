package lib;

import haxe.ds.Vector;

import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;

using sk.thenet.FM;

class Turner {
  public static var FRAMES:Int = 36;
  
  public var source:Bitmap;
  public var data:Vector<Bitmap>;
  
  public function new(source:Bitmap) {
    this.source = source;
    this.data = Vector.fromArrayCopy([ for (i in 0...FRAMES) null ]);
  }
  
  public function getAngle(a:Float):Bitmap {
    while (a < 0) a += 360;
    a %= 360;
    var frame = (a / (360 / FRAMES) - 0.5).floor() % FRAMES;
    if (data[frame] == null) {
      data[frame] = source.fluent >> new Rotate((a / 180) * Math.PI);
    }
    return data[frame];
  }
}
