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
  List<timerHistories> timerHistoriesList = [];

  void initState(){
    super.initState();
    loadingDatabase();
  }
  void loadingDatabase() async {
    print(DateTime.now());

    // await DbProvider.instance.rawQuery('''DELETE FROM LICHSUTIMER''');

    final histories = await DbProvider.instance.rawQuery('''
      select * from LICHSUTIMER where MANGUOIDUNG = '${StaticData.userID}'
      ''');
    print(histories);
    timerHistoriesList.clear();
    for (int i = 0; i < histories.length; i++) {
      timerHistories index = new timerHistories(
          histories[i]['MANGUOIDUNG'],
          DateTime.parse(histories[i]['THOIGIAN']),
          histories[i]['DAHOANTHANH'],
          );
      setState(() {
        timerHistoriesList.add(index);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              itemCount: timerHistoriesList.length,
              itemBuilder: (context, num) {
                return Container(
                  child: ListTile(  
                      leading: Text('${(num + 1 < 10)?' ${num + 1}':(num + 1)}', style: TextStyle(fontSize: 20),),
                      title: Text(timerHistoriesList[num].thoiGian.toString().split('.')[0] + "   -   "
                      + (timerHistoriesList[num].daHoanThanh == "true"?"Completed":"Incompleted").toString(),
                      style: TextStyle(fontSize: 19), overflow: TextOverflow.fade,),
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