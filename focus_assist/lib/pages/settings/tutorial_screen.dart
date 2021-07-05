import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key key}) : super(key: key);

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: (!StaticData.isDarkMode)?Colors.lightBlueAccent:Colors.grey[900],
      body: ListView(
        children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [(!StaticData.isDarkMode)?Colors.blue[200]:Colors.grey[900],(!StaticData.isDarkMode)?Colors.purple[200]:Colors.grey[700]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3,0.7],
                ),
              ),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 20,left: 20,top: 15,bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15),
                              color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[800],
                            ),
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                            ),
                          ),
                          SizedBox(width: size.width*0.18,),
                          Text(
                            'TUTORIAL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height*0.02,),
                      Container(
                        height: size.height*0.8,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70,
                        ),
                        child: ListView(
                          children:[ Padding(
                            padding: EdgeInsets.only(left:10,right: 10,bottom: 10,top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TextAlign.justifyTextAlign.justifyTextAlign.justifyTextAlign.justifyTextAlign.justify',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  //textAlign: TextAlign.center,
                                  //textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
