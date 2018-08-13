package lib;

enum RoomObject {
  Ragdoll(name:String, anim:Array<String>, tileX:Int, tileY:Int, interactive:Null<String>);
  Exit(tileX:Int, tileY:Int, tileW:Int, tileH:Int, pos:Direction, climb:Bool);
  Interaction(name:String, tileX:Int, tileY:Int, tileW:Int, tileH:Int);
  Visual(name:String);
}
