import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class card_shop extends StatelessWidget {
  final String MAVP;
  final String name;
  final int price;
  final String imageEgg;
  final Color rareColor;
  final bool isBuy;
  const card_shop({
    Key key,
    @required this.size, this.name, this.price, this.imageEgg, this.rareColor, this.MAVP, this.isBuy,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1,
                  offset: Offset(0,5),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height*0.03,),
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: rareColor,
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Text(
                        price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.overline,
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Container(
                        height: size.height*0.05,
                        width: size.width*0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FlatButton(
                            color: isBuy ? Colors.grey : Colors.green[400],
                            onPressed: () async {
                                String id = StaticData.userID;
                                //Kiểm tra có đủ tiền mua hay không
                                if (StaticData.Vang >= price ) {
                                  final e = await DbProvider.instance.rawQuery('''
                                  select * from VATPHAMNGUOIDUNG where MANGUOIDUNG = '$id' and MAVATPHAM = '$MAVP'
                                  '''
                                  );

                                  //Kiểm tra đã có trứng này chưa
                                  if (e.length == 0) {
                                     Map<String, dynamic> row = {'MAVATPHAM':MAVP , 'MANGUOIDUNG':StaticData.userID};
                                     int i = await DbProvider.instance.insert('VATPHAMNGUOIDUNG', row);
                                     StaticData.Vang -= price;


                                     //Nhận thành tựu
                                     int bonus;
                                     for (int i = 0; i < StaticData.AchiList.length; i++)
                                       {
                                         if(StaticData.AchiList[i].TENTHANHTUU == name)
                                           {
                                             bonus = StaticData.AchiList[i].bonus;
                                             StaticData.Vang += StaticData.AchiList[i].bonus;
                                             row = {'MATHANHTUU':StaticData.AchiList[i].MATHANHTUU, 'MANGUOIDUNG':StaticData.userID};
                                             int e = await DbProvider.instance.insert('THANHTUUNGUOIDUNG', row);
                                           }
                                       }


                                     int vang = StaticData.Vang;
                                     final k = await DbProvider.instance.rawQuery('''
                                     UPDATE THONGTINNGUOIDUNG
                                     SET VANG = $vang
                                     WHERE MANGUOIDUNG = '$id'
                                     ''');

                                     _showBILL(context, "Bạn nhận được thành tựu và thưởng $bonus", true);
                                   }
                                  else {
                                    _showBILL(context, "Bạn đã sở hữu quả trứng này", false);
                                  }

                                } else {
                                  _showBILL(context, "Không làm mà đòi có ăn :) ", false);
                                }

                            },
                            child: Text(
                              isBuy ? 'Đã mua' : 'Mua',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    imageEgg,
                    height: size.width*0.2,
                    width: size.width*0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Show thông báo
void _showBILL(context, String message, bool isBuy){
  if (isBuy == true) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "",
      closeIcon: Icon(Icons.error),
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "ACCEPT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  } else {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "",
      closeIcon: Icon(Icons.error),
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "ACCEPT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}




