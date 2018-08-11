package lib;

class Story {
  public static var flags:Map<String, Bool> = [
      "started" => false
    ];
  
  public static var ops = Operations.INDEX;
  public static var words = Word.INDEX;
}
