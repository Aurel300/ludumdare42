package lib;

@:forward(length, charAt, substr)
abstract Word(String) from String to String {
  public static var INDEX:Map<String, Word> = [ for (w in [
       "milk"
      ,"jump", "leap", "spring", "bound", "hop", "pounce"
      ,"walk", "stroll", "march", "run", "roam", "move", "go", "travel", "step"
      ,"climb", "ascend", "scale", "rise"
    ]) w => new Word(w) ];
  
  public function new(w:String) this = w;
  
  public var action(get, never):Action;
  private inline function get_action():Null<Action> return switch (this) {
    case "milk": Milk;
    case _: null;
  };
  
  public var ability(get, never):Ability;
  private inline function get_ability():Null<Ability> return switch (this) {
    case "jump" | "leap" | "spring" | "bound" | "hop" | "pounce": Jump;
    case "walk" | "stroll" | "march" | "run" | "roam" | "move" | "go" | "travel" | "step": Walk;
    case "climb" | "ascend" | "scale" | "rise": Climb;
    case _: null;
  };
}
