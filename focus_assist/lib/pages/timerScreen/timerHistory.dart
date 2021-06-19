import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:focus_assist/classes/ClassTimerHistory.dart';
import 'package:focus_assist/classes/Data.dart';
class timerHistory extends StatefulWidget {
  @override
  _timerHistoryState createState() => _timerHistoryState();
}

class _timerHistoryState extends State<timerHistory> {
  void initState(){
    super.initState();
    loadingDatabase();
  }
  void loadingDatabase() async {
    String id = StaticData.userID;
    final histories = await DbProvider.instance.rawQuery('''
      select * from LICHSUTIMER where MANGUOIDUNG = '$id'
      ''');
      StaticData.timerHistoriesList.clear();
      for (int i = 0; i < histories.length; i++) {
            timerHistories index = new timerHistories(
                histories[i]['MANGUOIDUNG'],
                histories[i]['THOIGIAN'],
                histories[i]['DAHOANTHANH'],
                );
            setState(() {
              StaticData.timerHistoriesList.add(index);
            });
      }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              itemCount: StaticData.timerHistoriesList.length,
              itemBuilder: (context, num) {
                return Container(
                  child: ListTile(  
                      leading: Text('${num + 1}', style: TextStyle(fontSize: 25),),
                      title: Text(StaticData.timerHistoriesList[num].thoiGian.toString() + "   -   " 
                      + (StaticData.timerHistoriesList[num].daHoanThanh == "true"?"Completed":"Incompleted").toString(),
                      style: TextStyle(fontSize: 20), overflow: TextOverflow.fade,),
                    ), 
                );
              });
    // return Row(
    //   children: [
    //     // ElevatedButton(onPressed: (){
    //     //   for (int i = 0; i < StaticData.timerHistoriesList.length; i ++)
    //     //                     {
    //     //                       print(StaticData.timerHistoriesList[i].thoiGian.toString());
    //     //                     }
    //     // }, 
    //     // child: Text("button")),
    //     Container(

    //       child: ListView.builder(
    //           itemCount: StaticData.timerHistoriesList.length,
    //           itemBuilder: (context, num) {
    //             for (int i = 0; i < StaticData.timerHistoriesList.length; i ++)
    //                         {
    //                           print(StaticData.timerHistoriesList[num].thoiGian.toString());
    //                         }
    //             return Container(
    //               child: ListTile(  
    //                   leading: Text('$num', style: TextStyle(fontSize: 25),),   
    //                   // title: Text(StaticData.timerHistoriesList[num].thoiGian.toString() + " " 
    //                   // + StaticData.timerHistoriesList[num].daHoanThanh.toString() ),   
    //                 ), 
    //             );
    //           }),
    //     )
    //   ],
    // );
  }
}