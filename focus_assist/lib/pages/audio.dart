import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MyApp());
}

void playvoice(int voiceno) {
  audioCache.play('v$voiceno.mp3');
}

void stopvoice(int voiceno) {
  audioPlayer.pause();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

AudioCache audioCache;
AudioPlayer audioPlayer;

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();

    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/CategoryPage': (context) => CategoryPage(),
        '/TitlePage': (context) => TitlePage(),
        '/StoryPage': (context) => StoryPage(),
        '/EndPage': (context) => EndPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Image.asset(
                'images/bb.jpg',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
              Positioned(
                bottom: 20.0,
                left: 330.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/CategoryPage');
                  },
                  color: Colors.pinkAccent[200],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Start',
                      style: TextStyle(
                        fontFamily: 'Ranchers',
                        fontSize: 45.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/sky.jpg'), fit: BoxFit.fill),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 85.0),
                  child: Center(
                    child: Text(
                      "Stories",
                      style: TextStyle(
                        fontFamily: 'Ranchers',
                        fontSize: 40.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.yellow,
                      ),
                      FlatButton(
                        child: Text(
                          "   The    Grasshopper   and   the   Ant",
                          style: TextStyle(
                              fontFamily: 'Ranchers',
                              fontSize: 30.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/TitlePage');
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.yellow,
                      ),
                      FlatButton(
                        child: Text(
                          "   The    Ugly    Duckling",
                          style: TextStyle(
                              fontFamily: 'Ranchers',
                              fontSize: 30.0,
                              color: Colors.white),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.yellow,
                    ),
                    FlatButton(
                      child: Text(
                        "   The   tortoise  and   the   Rabbit",
                        style: TextStyle(
                            fontFamily: 'Ranchers',
                            fontSize: 30.0,
                            color: Colors.white),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    playvoice(0);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/sky.jpg'), fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Text(
                  "   The    Grasshopper   and   the   Ant",
                  style: TextStyle(
                    fontFamily: 'Ranchers',
                    fontSize: 40.0,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.play_circle_filled),
              iconSize: 70,
              color: Colors.white,
              alignment: Alignment.center,
              splashColor: Colors.yellow,
              onPressed: () {
                Navigator.pushNamed(context, '/StoryPage');
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 550.0, 10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/CategoryPage');
                  stopvoice(0);
                },
                color: Colors.yellow,
                textColor: Colors.teal[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19.0)),
                splashColor: Colors.lightBlueAccent,
                child: Text('Go  Back',
                    style: TextStyle(
                      fontFamily: 'Ranchers',
                      fontSize: 35.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int n = 1;
  @override
  Widget build(BuildContext context) {
    playvoice(n);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage('images/sky.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 10.0),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Image(
                    image: AssetImage('images/a$n.gif'),
                    height: 270.0,
                    width: 800.0,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1.0, horizontal: 300.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      iconSize: 60,
                      color: Colors.white,
                      alignment: Alignment.center,
                      onPressed: () {
                        stopvoice(n);
                        if (n == 1) {
                          stopvoice(n);
                          Navigator.pushNamed(context, '/CategoryPage');
                        } else {
                          setState(() {
                            stopvoice(n);
                            n = n - 1;
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      iconSize: 60,
                      color: Colors.white,
                      alignment: Alignment.center,
                      onPressed: () {
                        setState(
                          () {
                            if (n < 5) {
                              n = n + 1;
                            } else {
                              stopvoice(n);
                              Navigator.pushNamed(context, '/EndPage');
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class EndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage('images/e.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                iconSize: 60,
                color: Colors.yellow,
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.pushNamed(context, '/CategoryPage');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: Text(
                  "The  End",
                  style: TextStyle(
                    fontFamily: 'BilboSwashCaps',
                    fontWeight: FontWeight.bold,
                    fontSize: 80.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}