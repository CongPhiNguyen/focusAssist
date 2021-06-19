import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:focus_assist/classes/DbProvider.dart';

class ListAchivement extends StatefulWidget {
  const ListAchivement({Key key}) : super(key: key);

  @override
  _ListAchivementState createState() => _ListAchivementState();
}

class _ListAchivementState extends State<ListAchivement> {
  //Đây sẽ list các thành tựu các kiếu sau
  Future<int> countDone() async {
    String key = StaticData.userID;
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as SOLAN from THONGKE tk join MUCTIEU mt on tk.MAMUCTIEU=mt.MAMUCTIEU where mt.MANGUOIDUNG='$key' ''');
    return data[0]['SOLAN'];
  }

  Future<void> getCount() async {
    int dones = await countDone();
    doneNum = dones;
  }

  void getData() async {
    await getCount();
    await getCurrentLevel();
    if (this.mounted) {
      setState(() {
        if (currentDoneLevel == 4)
          currentDoneTarget = targetDone[2];
        else
          currentDoneTarget = targetDone[currentDoneLevel - 1];
        percentDone = doneNum * 1.0 / currentDoneTarget;

        percentActivity = doneNumLeft * 1.0 / targetToReach;
      });
    } else
      return;
  }

  Future<int> getCurrentActivityLevel() async {
    //int levelNow = (doneNum / 75).round();
    int countDatabaseLevel = 0;
    String key = StaticData.userID;
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as SOLAN from THANHTUU t join THANHTUUNGUOIDUNG tn on t.MATHANHTUU=tn.MATHANHTUU where tn.MANGUOIDUNG='$key' and t.VANG=20  ''');
    countDatabaseLevel = data[0]['SOLAN'];
    print('shit' + countDatabaseLevel.toString());
    return countDatabaseLevel;
  }

  Future<int> getCurrentDoneLevel() async {
    String userID = StaticData.userID;
    // Xem thử đã qua cấp 3 chưa
    String maThanhTuu = 'TT03';
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data[0]['DEM'] > 0) {
      if (this.mounted) {
        setState(() {
          isFullDone = true;
        });
      }
      return 4;
    }
    // Xem thử đã qua cấp 2 chưa
    maThanhTuu = 'TT04';
    List<Map<String, dynamic>> data1 = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data1[0]['DEM'] > 0) {
      return 3;
    }
    // Xem thử qua cấp 1 hay chưa
    maThanhTuu = 'TT01';
    List<Map<String, dynamic>> data2 = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data2[0]['DEM'] > 0) {
      return 2;
    }
    return 1;
  }

  Future<void> getCurrentLevel() async {
    int currentDone = await getCurrentDoneLevel();
    int currentActive = await getCurrentActivityLevel();
    print('currentDone: $currentDone currentActive: $currentActive');
    if (this.mounted) {
      setState(() {
        currentDoneLevel = currentDone;
        currentActivityLevel = currentActive;
      });
      setState(() {
        doneNumLeft = doneNum - (currentActive - 1) * targetToReach;
      });
    } else
      return;
  }

  int targetToReach;
  int doneNum = 0, doneNumLeft = 0;
  List<int> targetDone = [100, 500, 1500]; //[1, 3, 5]; //[100, 500, 1500];
  int currentDoneLevel,
      currentActivityLevel,
      currentDoneTarget,
      currentActivityTarget;
  double percentDone, percentActivity;
  final dbHelper = DbProvider.instance;
  bool isFullDone = false;

  @override
  void initState() {
    super.initState();
    percentDone = 0.0;
    percentActivity = 0.0;
    currentDoneTarget = 0;
    currentActivityTarget = 0;
    currentActivityLevel = 1;
    currentDoneLevel = 1;
    targetToReach = 75;
    getData();
  }

  void finishClick() async {
    if (percentDone < 1.0) return;
    if (currentDoneLevel >= 4) {
      if (this.mounted) {
        setState(() {
          isFullDone = true;
        });
      } else
        return;

      return;
    } else if (currentDoneLevel == 3) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'TT03',
        'TENTHANHTUU': 'Finish $currentDoneTarget times',
        'CAPDO': 3,
        'VANG': 300
      };
      print(row);
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'TT03', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 300;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentDoneLevel == 2) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'TT04',
        'TENTHANHTUU': 'Finish $currentDoneTarget times',
        'CAPDO': 2,
        'VANG': 100
      };
      print(row);
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'TT04', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 100;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentDoneLevel == 1) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'TT01',
        'TENTHANHTUU': 'Finish $currentDoneTarget times',
        'CAPDO': 1,
        'VANG': 25
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'TT01', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 25;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    }
  }

  void haveClick() async {
    if (percentActivity < 1.0) return;
    String maThanhTuu = 'TT';
    int newNum = 5 + (currentActivityLevel % 53);
    String newNum2 = newNum.toString();
    while (newNum2.length < 2) {
      newNum2 = '0' + newNum2;
    }
    maThanhTuu += newNum2;
    Map<String, dynamic> row = {
      'MATHANHTUU': maThanhTuu,
      'TENTHANHTUU':
          'Finish ${(currentActivityLevel + 1) * targetToReach} times',
      'CAPDO': 1,
      'VANG': 20
    };
    print('have:$row');
    final id = await dbHelper.insert('THANHTUU', row);
    print('inserted row id: $id');
    row = {'MATHANHTUU': maThanhTuu, 'MANGUOIDUNG': StaticData.userID};
    final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
    print('inserted row id: $id2');

    int golds = StaticData.Vang += 20;
    //Add vàng vào database
    String userKey = StaticData.userID;
    dbHelper.rawQuery(
        ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                Image.asset('assets/achievement.png', width: 60, height: 60),
                SizedBox(
                  width: 20,
                ),
                Center(
                    child: Text(
                  "Achivements",
                  style: TextStyle(fontSize: 30),
                )),
              ]),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text("Finish $currentDoneTarget times",
                            style: TextStyle(fontSize: 20)),
                      )),
                  Expanded(
                    flex: 2,
                    child: LinearPercentIndicator(
                      center: Text('$doneNum/$currentDoneTarget'),
                      //width: 100.0,
                      lineHeight: 14.0,
                      percent: (percentDone >= 1) ? 1.0 : percentDone,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: finishClick,
                        style: ElevatedButton.styleFrom(
                          primary: !isFullDone ? Colors.blue : Colors.grey,
                        ),
                        child: Text(
                          'Claim',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text("Done $targetToReach times",
                            style: TextStyle(fontSize: 20)),
                      )),
                  Expanded(
                    flex: 2,
                    child: LinearPercentIndicator(
                      center: Text("$doneNumLeft/$targetToReach"),
                      lineHeight: 14.0,
                      percent: (percentActivity >= 1) ? 1.0 : percentActivity,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: haveClick,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          'Claim',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                ]),
              ),
            ],
          ),
        )));
  }
}
