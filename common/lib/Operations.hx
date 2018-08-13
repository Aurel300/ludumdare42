package lib;

class Operations {
  // single word
  static inline function sw(f:Word->Null<Word>):Array<Word>->Null<Array<Word>> {
    return ws -> {
      var o = f(ws[0]);
      o == null || o.length == 0 || o == ws[0] ? null : [o];
    };
  }
  
  // single word operation
  static inline function swo(f:Word->Null<Word>):Operation {
    return { i: 1, o: 1, f: sw(f) };
  }
  
  public static var ALPHA = "abcdefghijklmnopqrstuvwxyz".split("");
  public static var ALPHA_INC = "bcdefghijklmnopqrstuvwxyzz".split("");
  public static var ALPHA_DEC = "aabcdefghijklmnopqrstuvwxy".split("");
  public static var ALPHA_DEC3 = "aaaabcdefghijklmnopqrstuvw".split("");
  
  public static var INDEX:Map<String, Operation> = [
     "1inc" => swo(w -> ALPHA_INC[ALPHA.indexOf(w.charAt(0))] + w.substr(1))
    ,"19rev" => swo(w -> w.length >= 2 ? (w.charAt(w.length - 1) + w.substr(1, w.length - 2) + w.charAt(0)) : null)
    ,"1cut" => swo(w -> w.substr(1))
    ,"c-" => swo(w -> (w:String).split("").filter(c -> c != "c").join(""))
    ,"1dec*3" => swo(w -> ALPHA_DEC3[ALPHA.indexOf(w.charAt(0))] + w.substr(1))
    ,"o-u" => swo(w -> (w:String).split("").map(c -> c == "o" ? "u" : c).join(""))
    ,"rev" => swo(w -> {
        var cs = (w:String).split("");
        cs.reverse();
        cs.join("");
      })
  ];
}
