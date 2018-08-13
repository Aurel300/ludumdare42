package lib;

import sk.thenet.app.AssetManager;

using StringTools;

class Sfx {
  static var am:AssetManager;
  
  static var music:Map<String, Crossfade>;
  public static var currentMusic:String = "";
  
  public static function isMusic(s:String):Bool {
    return s.startsWith("loop") || s.startsWith("theme");
  }
  
  public static function init(am):Void {
    Sfx.am = am;
  }
  
  public static function initMusic():Void {
    if (music == null) music = [
       "loop-mecha" => new Crossfade("loop-mecha")
      ,"loop-wind" => new Crossfade("loop-wind")
      ,"theme-cuttlefish" => new Crossfade("theme-cuttlefish")
      ,"theme-deepspace" => new Crossfade("theme-deepspace")
      ,"theme-main" => new Crossfade("theme-main")
      ,"theme-noise" => new Crossfade("theme-noise")
    ];
  }
  
  public static function play(s:String, ?volume:Float = 1, ?forever:Bool = false) {
    var m = isMusic(s);
    var shouldPlay = m ? SGame.musicOn : SGame.soundOn;
    return am.getSound(m ? s : 'sfx-$s').play(forever ? Forever : Once, shouldPlay ? volume : 0);
  }
  
  public static function tick():Void {
    for (k in music.keys()) music[k].tick(currentMusic == k);
  }
}
