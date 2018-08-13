package lib;

enum Slot {
  Empty;
  Word(w:Word);
  Map(m:MapFragment);
}
