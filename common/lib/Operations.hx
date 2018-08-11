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
  
  static var ALPHA = "abcdefghijklmnopqrstuvwxyz".split("");
  static var ALPHA_INC = "bcdefghijklmnopqrstuvwxyzz".split("");
  static var ALPHA_DEC = "aabcdefghijklmnopqrstuvwxy".split("");
  
  public static var INDEX:Map<String, Operation> = [
    "1inc" => swo(w -> ALPHA_INC[ALPHA.indexOf(w.charAt(0))] + w.substr(1)),
    "19rev" => swo(w -> w.length >= 2 ? (w.charAt(w.length - 1) + w.substr(1, w.length - 2) + w.charAt(0)) : null),
    "1cut" => swo(w -> w.substr(1))
  ];
}
