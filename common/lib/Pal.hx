package lib;

import haxe.ds.Vector;
import sk.thenet.bmp.*;

class Pal {
  public static var P:Vector<Colour>;
  
  public static function init(amB:String->Bitmap):Void {
    var pal = amB("pal");
    P = Vector.fromArrayCopy([ for (y in 0...3) for (x in 0...18) pal.get(x * 8, y * 8) ]);
  }
}
