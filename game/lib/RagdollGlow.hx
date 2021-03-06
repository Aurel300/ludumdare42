package lib;

import sk.thenet.bmp.*;

using sk.thenet.FM;

class RagdollGlow extends Manipulator {
  public var colour(default, null):Colour;
  
  public var xMin:Int = 0;
  public var yMin:Int = 0;

  public var xMax:Int = 0;
  public var yMax:Int = 0;
  
  public function new(colour:Colour) {
    this.colour = colour;
  }
  
  override public function manipulate(bitmap:Bitmap):Void {
    xMax = yMax = 0;
    xMin = bitmap.width;
    yMin = bitmap.height;
    var vec = bitmap.getVector();
    var ovec = vec.copy();
    var i:Int = 0;
    for (y in 0...bitmap.height) for (x in 0...bitmap.width) {
      if ((vec[i] & 0xFF000000) != 0) {
        //vec[i] = 0xFF00FFFF;
        // pass
      } else if ((x > 0 && (ovec[i - 1] & 0xFF000000) != 0)
          || (y > 0 && (ovec[i - bitmap.width] & 0xFF000000) != 0)
          || (x < bitmap.width - 1 && (ovec[i + 1] & 0xFF000000) != 0)
          || (y < bitmap.height - 1 && (ovec[i + bitmap.width] & 0xFF000000) != 0)
          || (x > 0 && y > 0 && (ovec[i - 1 - bitmap.width] & 0xFF000000) != 0)
          || (x < bitmap.width - 1 && y > 0 && (ovec[i + 1 - bitmap.width] & 0xFF000000) != 0)
          || (x < bitmap.width - 1 && y < bitmap.height - 1 && (ovec[i + 1 + bitmap.width] & 0xFF000000) != 0)
          || (x > 0 && y < bitmap.height - 1 && (ovec[i - 1 + bitmap.width] & 0xFF000000) != 0)) {
        yMin = yMin.minI(y);
        xMin = xMin.minI(x);
        yMax = yMax.maxI(y);
        xMax = xMax.maxI(x);
        vec[i] = colour;
      }
      i++;
    }
    bitmap.setVector(vec);
  }
}
