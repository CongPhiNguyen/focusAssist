import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/pages/settings/tutorial_screen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<Info> member = [
    Info('Thiện Phước', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.greenAccent,'19522055'),
    Info('Công Phi', '03/12/2001', '0329418197', '19522006@gm.uit.edu.vn', Colors.redAccent,'19522055'),
    Info('Như Phước', '29/03/2001', '0362103314', '19522052@gm.uit.edu.vn', Colors.purpleAccent,'19522055'),
    Info('Dận Quang', '17/10/2001', '0914394514', '19522092@gm.uit.edu.vn', Colors.blueAccent,'19522055'),
    // Info('Dận Quang', '17/10/2001', '0914394514', '19522092@gm.uit.edu.vn', Colors.blueAccent,'19522055'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: (!StaticData.isDarkMode)?Colors.lightBlueAccent:Colors.grey[900],
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [(!StaticData.isDarkMode)?Colors.blue[200]:Colors.grey[900],(!StaticData.isDarkMode)?Colors.purple[200]:Colors.grey[700]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3,0.7],
              ),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20,left: 20,top: 15,bottom: 15),
                    child: Container(
                      height: size.height*0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[800],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Text(
                            'ABOUT US',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[300],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[800],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TutorialScreen();
                                    },
                                  ),
                                );
                              },
                              child:
                              Image.asset('assets/achievenment/ui/tutorial.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height*0.25,
                    width: size.width,
                    child: Image.asset('assets/achievenment/ui/about-us.gif'),
                  ),
                  Center(
                    child: Container(
                      height: size.height*0.6,
                      child: Swiper(
                          itemCount: member.length,
                          itemWidth: MediaQuery.of(context).size.width-2*60,
                          itemHeight: size.height*0.5,
                          customLayoutOption: new CustomLayoutOption(
                              startIndex: -1,
                              stateCount: 3
                          ).addRotate([
                            -45.0/180,
                            0.0,
                            45.0/180
                          ]).addTranslate([
                            new Offset(-400.0, -40.0),
                            new Offset(0.0, 0.0),
                            new Offset(400.0, -40.0)
                          ]),
                          layout: SwiperLayout.CUSTOM,
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                activeSize: 10,
                                space: 10,
                                color: Colors.grey,
                                activeColor: Colors.white,
                              )
                          ),
                          itemBuilder: (context,index){
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height:size.height*0.05),
                                    Card(
                                      elevation: 10,
                                      color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[700],
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding:EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height:size.height*0.12,),
                                            Text(
                                              member[index].name,
                                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 15,),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.cake,size: 20,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  member[index].birth,
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.email,size: 20,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  member[index].mail,
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.phone_android_rounded,size: 20,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  member[index].phone,
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height*0.20,
                                  width: size.height*0.2,
                                  //child: Image.asset('assets/achievenment/Eggs/eggDemon.png'),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    //radius: 10,
                                    child: ClipOval(
                                      child: Image.asset('assets/'+index.toString()+'.PNG'),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
