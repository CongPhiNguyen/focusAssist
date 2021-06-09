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
  Future<int> countActivity() async {
    String key = StaticData.userID;
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as SOMUCTIEU from MUCTIEU where MANGUOIDUNG='$key' ''');
    return data[0]['SOMUCTIEU'];
  }

  Future<int> countDone() async {
    String key = StaticData.userID;
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as SOLAN from THONGKE tk join MUCTIEU mt on tk.MAMUCTIEU=mt.MAMUCTIEU where mt.MANGUOIDUNG='$key' ''');
    return data[0]['SOLAN'];
  }

  int doneNum = 0, activityNum = 0;
  Future<void> getCount() async {
    int dones = await countDone();
    int activities = await countActivity();
    doneNum = dones;
    activityNum = activities;
  }

  void getData() async {
    await getCount();
    await getCurrentLevel();
    setState(() {
      currentDoneTarget = currentDoneLevel * 10;
      if (currentDoneTarget > 30) currentDoneTarget = 30;
      percentDone = doneNum * 1.0 / currentDoneTarget;
    });

    setState(() {
      currentActivityTarget = currentActivityLevel * 3;
      if (currentActivityTarget > 30) currentActivityTarget = 30;
      percentActivity = activityNum * 1.0 / currentActivityTarget;
    });
  }

  Future<int> getCurrentActivityLevel() async {
    String userID = StaticData.userID;
    // Xem thử đã qua cấp 3 chưa
    String maThanhTuu = 'ACTIVE3';
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data[0]['DEM'] > 0) {
      setState(() {
        isFullActive = true;
      });
      return 4;
    }
    // Xem thử đã qua cấp 2 chưa
    maThanhTuu = 'ACTIVE2';
    List<Map<String, dynamic>> data1 = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data1[0]['DEM'] > 0) {
      return 3;
    }
    // Xem thử qua cấp 1 hay chưa
    maThanhTuu = 'ACTIVE1';
    List<Map<String, dynamic>> data2 = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data2[0]['DEM'] > 0) {
      return 2;
    }
    return 1;
  }

  Future<int> getCurrentDoneLevel() async {
    String userID = StaticData.userID;
    // Xem thử đã qua cấp 3 chưa
    String maThanhTuu = 'DONE3';
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data[0]['DEM'] > 0) {
      setState(() {
        isFullDone = true;
      });
      return 4;
    }
    // Xem thử đã qua cấp 2 chưa
    maThanhTuu = 'DONE2';
    List<Map<String, dynamic>> data1 = await dbHelper.rawQuery(
        '''select count(*) as DEM from THANHTUU tt join THANHTUUNGUOIDUNG nd on tt.MATHANHTUU=nd.MATHANHTUU where MANGUOIDUNG='$userID' and tt.MATHANHTUU='$maThanhTuu' ''');
    if (data1[0]['DEM'] > 0) {
      return 3;
    }
    // Xem thử qua cấp 1 hay chưa
    maThanhTuu = 'DONE1';
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
    setState(() {
      currentDoneLevel = currentDone;
      currentActivityLevel = currentActive;
    });
  }

  int currentDoneLevel,
      currentActivityLevel,
      currentDoneTarget,
      currentActivityTarget;
  double percentDone, percentActivity;
  final dbHelper = DbProvider.instance;
  bool isFullActive = false, isFullDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    percentDone = 0.0;
    percentActivity = 0.0;
    currentDoneTarget = 0;
    currentActivityTarget = 0;
    currentActivityLevel = 1;
    currentDoneLevel = 1;
    getData();
  }

  void FinishClick() async {
    if (percentDone < 1.0) return;
    if (currentDoneLevel >= 4) {
      setState(() {
        isFullDone = true;
      });
      return;
    } else if (currentDoneLevel == 3) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'DONE3',
        'TENTHANHTUU': 'Finish 30 times',
        'CAPDO': 3,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'DONE3', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentDoneLevel == 2) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'DONE2',
        'TENTHANHTUU': 'Finish 20 times',
        'CAPDO': 2,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'DONE2', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentDoneLevel == 1) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'DONE1',
        'TENTHANHTUU': 'Finish 10 times',
        'CAPDO': 1,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'DONE1', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    }
  }

  void HaveClick() async {
    if (percentActivity < 1.0) return;
    if (currentActivityLevel >= 4) {
      setState(() {
        isFullActive = true;
      });
      return;
    } else if (currentActivityLevel == 3) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'ACTIVE3',
        'TENTHANHTUU': 'Have 9 activities',
        'CAPDO': 3,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'ACTIVE3', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentActivityLevel == 2) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'ACTIVE2',
        'TENTHANHTUU': 'Have 6 activities',
        'CAPDO': 2,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'ACTIVE2', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    } else if (currentActivityLevel == 1) {
      Map<String, dynamic> row = {
        'MATHANHTUU': 'ACTIVE1',
        'TENTHANHTUU': 'Have 3 activities',
        'CAPDO': 1,
        'VANG': 100
      };
      final id = await dbHelper.insert('THANHTUU', row);
      print('inserted row id: $id');
      row = {'MATHANHTUU': 'ACTIVE1', 'MANGUOIDUNG': StaticData.userID};
      final id2 = await dbHelper.insert('THANHTUUNGUOIDUNG', row);
      print('inserted row id: $id2');

      int golds = StaticData.Vang += 50;
      //Add vào database
      String userKey = StaticData.userID;
      dbHelper.rawQuery(
          ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');

      getData();
    }
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
                  "All achivements",
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
                      percent: (percentDone > 1) ? 1.0 : percentDone,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: FinishClick,
                        style: ElevatedButton.styleFrom(
                          primary: !isFullDone ? Colors.blue : Colors.purple,
                        ),
                        child: Text('Claim'),
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
                        child: Text("Have $currentActivityTarget activity",
                            style: TextStyle(fontSize: 20)),
                      )),
                  Expanded(
                    flex: 2,
                    child: LinearPercentIndicator(
                      center: Text("$activityNum/$currentActivityTarget"),
                      //width: 100.0,
                      lineHeight: 14.0,
                      percent: (percentActivity > 1) ? 1.0 : percentActivity,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: HaveClick,
                        style: ElevatedButton.styleFrom(
                          primary: !isFullActive ? Colors.blue : Colors.purple,
                        ),
                        child: Text('Claim'),
                      ))
                ]),
              ),
            ],
          ),
        )));
  }
}
