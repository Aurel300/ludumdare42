package lib;

class Inventory {
  public var slots:Array<Slot>;
}

enum Slot {
  Word(w:Word);
  Map(m:MapFragment);
}
