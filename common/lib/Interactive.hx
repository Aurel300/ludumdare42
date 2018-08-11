package lib;

import lib.Room.ExitPosition;

class Interactive {
  public static var INDEX:Map<String, Interactive> = [
    "ss-sap" => new Interactive([
         Text('In your path stands a man, looking at a nearby tree very thoughtfully.')
        ,Text('"I seek synonyms," the man exclaims, when he notices you.')
        ,Text('"So many words, numerous, countless, infinite!"')
        ,Text('"You, robot, android, my machine friend, can you help me?"')
        ,Text('He pauses and seems a little bit embarassed.')
        ,Text('"I don\'t even know a single term for the fluid of a tree," he admits, "let alone any synonyms!"')
        ,Text('"Can you help me?"')
        ,Text('You suggest to the synonym seeker ...')
        ,Take(["sap"])
        ,Text('"Sap! What a sap I have been ... Thank you!"')
        ,Open(Right)
      ])
    ,"climber" => new Interactive([
         Text('You take in a strange scene: a robot, going up a ladder, but never getting anywhere. The ladder descends just as fast as the robot can ascend. Does it need to exercise to keep fit?')
        ,Text('With machine-like precision, the robot puts its arms on each step of the ladder, one at a time.')
        ,Text('You can only feel wonder at the robot and its infinite ...')
        ,Take(["climb"])
        ,Text('"Robogym," says the sign.')
      ])
    ,"king" => new Interactive([
         Text('You enter the royal court of King Kinplot.')
        ,Branch([
            {conditions: ["queen-helped" => true], fragments: [
                 Text('"Welcome, friendly mechanoid," says the King.')
                ,Text('"I heard thou gifted fine silk garments to my Queen. Thou art a friend of the Kingdom indeed! Kneel before the King!"')
                ,Text('"For thy services, I dub thee Sir PLYR. Rise now, my ..."')
                ,Take(["knight"])
                ,Text('You feel blue blood surging through your metal body as you leave.')
              ]}
            ,{conditions: null, fragments: [
                 Text('"Welcome, strange mechanoid," says the King.')
                ,Text('You bow. Perhaps you should come back later.')
              ]}
          ])
      ])
    ,"hey" => new Interactive([
         Text('You see a friendly guy looking at you.')
        ,Text('"Hi," says he.')
        ,Text('Is he a friend? You can\'t quite remember. You reply ...')
        ,Take(["hey"])
        ,Text('An awkard stretch of silence seems to fill the room now.')
      ])
    ,"rev" => new Interactive([
         Text('You see a large railway turntable in the middle of a train depot. A sign says quietly, "Zorktown depot."')
        ,Text('A train from Annaburg to Zorktown slowly moves onto the turntable, signals to the operator, and the train is rotated - slowly.')
        ,Text('"All aboard," you hear on the PA, "for the express to Annaburg!"')
        ,Text('The turntable is now empty.')
        ,Operation("rev")
      ])
    ,"c-" => new Interactive([
         Text('A pirate stands by his lonesome on the seashore. He is holding up a telescope to his left eye. You cannot tell why, for both of his eyes are covered with eyepatches.')
        ,Text('"I see no seas at the seashore," he mutters to himself.')
        ,Text('"Yet the sound of seas is all I hear!"')
        ,Text('He seems to dislike the sound of the seas.')
        ,Operation("c-")
      ])
    ,"1cut" => new Interactive([
         Text('*swish* *thud*')
        ,Text('A chef cuts the head of a fish clean off just as you enter the kitchen.')
        ,Text('"Many a trout dares to enter my kitchen," he grins, "yet with a swish and a thud they are put to rout."')
        ,Operation("1cut")
      ])
    ,"19rev" => new Interactive([
         Text('A funfair stretches before you. Stalls of wild colours, games, rides, and a certain smell that can only be described as typical.')
        ,Text('After some meandering, you join a small gathering of people, watching a jester juggling colourful balls. Red goes up, then blue, green, and finally yellow. Their height seem random and yet the jester is in full control. Yellow is back in his hand, then the blue, green, and finally red. The crowd applauds - clearly the trick was very impressive.')
        ,Text('You, however, are not impressed, and the lack of any emotional circuitry in your braincase is not the reason.')
        ,Text('Juggling balls is easy - how about juggling ...')
        ,Operation("19rev")
      ])
    ,"1inc" => new Interactive([
         Text('"See dee ee?" a woman asks you.')
        ,Text('Noticing your confusion, the woman continues, as if to explain, "oh, pick you!"')
        ,Text('You realise she is waiting for something.')
        ,Operation("1inc")
      ])
    ,"1dec*3" => new Interactive([
         Text('"Fallen down, \'ave you," a beggar asks.')
        ,Text('"We all do sometimes, pal. Tell you what, gimme some change and I\'ll shave it down a step or three."')
        ,Operation("1dec*3")
      ])
    ,"o-u" => new Interactive([
         Text('You see a gigantic fish in the room.')
        ,Text('"Oh, you," it says.')
        ,Text('It doesn\'t seem particularly bothered about the world around it, not even the fact that it is a fish out of water. It probably has yet to notice.')
        ,Text('"Oh, you," it repeats, vacantly.')
        ,Operation("o-u")
      ])
  ];
  
  public var fragments:Array<IaFragment>;
  
  public function new(f:Array<IaFragment>) {
    this.fragments = f;
  }
}

enum IaFragment {
  Text(msg:String);
  Image(name:String);
  Operation(name:String);
  Give(words:Array<Word>);
  Take(words:Array<Word>);
  Riddle(words:Array<Word>);
  Branch(branches:Array<IaBranch>);
  SetFlag(flag:String, value:Bool);
  Open(exit:ExitPosition);
}

typedef IaBranch = {
     conditions:Map<String, Bool>
    ,fragments:Array<IaFragment>
  };
