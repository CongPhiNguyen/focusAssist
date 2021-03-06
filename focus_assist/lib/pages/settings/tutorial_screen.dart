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
                          color: (!StaticData.isDarkMode)?Colors.white70:Colors.grey[700],
                        ),
                        child: ListView(
                          children:[ Padding(
                            padding: EdgeInsets.only(left:10,right: 10,bottom: 10,top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Qu???n l?? t???i kho???n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[300],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial1.PNG'),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	????ng k?? v?? ????ng nh???p: ????? t???o t??i kho???n m???i, t???i m??n h??nh ????ng nh???p, ng?????i d??ng nh???n n??t SIGN UP, sau ???? ??i???n th??ng tin bao g???m Name, Username v?? Password, Sau ???? ti???n h??nh ????ng nh???p t???i m??n h??nh Login.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial2.PNG'),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	T??m l???i m???t kh???u: D??ng nh???ng c??u tr??? l???i c???a QuestionScreen ????? gi??p b???n l???y l???i m???t kh???u.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '2. Qu???n l?? c??c th??i quen',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[300],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                //SizedBox(height: 5,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial3.PNG'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Trong m??n h??nh n??y, ng?????i d??ng c?? th??? t???o, ch???nh s???a, x??a, ph??n lo???i th??i quen. .',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	????? t???o th??i quen m???i, ng?????i d??ng nh???n v??o n??t (+) ??? g??c ph???i m??n h??nh, sau ???? ti???n h??nh nh???p t??n th??i quen (Activity Name), M?? t??? (Description), Ng??y b???t ?????u (Start Day), Nh??m th??i quen (Group, d??ng ????? ph??n lo???i c??c th??i quen) v?? cu???i c??ng l?? l???a ch???n l???p l???i th??i quen g???m 3 ch??? ?????: Fixed, Flexible v?? Repeating. Trong ???? ch??? ????? Fixed cho ph??p ng?????i d??ng l???p l???i th??i quen ??? c??c ng??y nh???t ?????nh trong tu???n, ch??? ????? Flexible cho ph??p ng?????i d??ng ch???n l???p l???i theo s??? ng??y trong tu???n v?? cu???i c??ng l?? Repeating cho ph??p th??ng b??o th??i quen b???ng c??ch l???p l???i c??ch m???i N ng??y.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Theo d??i th??i quen b???ng bi???u ????? th???ng k??..',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	????? theo d??i qu?? tr??nh th???c hi???n c???a 1 th??i quen, ng?????i d??ng c?? th??? ???n v??o m???t ho???t ?????ng b???t k?? tr??n m??n h??nh ch??nh, t???i m??n h??nh theo d??i (m??n h??nh 3) s??? cho ph??p ng?????i d??ng xem chi ti???t qu?? tr??nh th???c hi???n th??i quen m???i ng??y v?? th???ng k?? ti???n ????? th???c hi???n c???a ho???t ?????ng ???? b???ng bi???u ????? tr??n. Ngo??i ra ng?????i d??ng c??n c?? th??? x??a th??i quen ho???c ch???nh s???a th??i quen b???ng c??c ti???n ??ch ??? tr??n c??ng m??n h??nh.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Th??ng b??o, nh???c nh??? h???ng ng??y.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	????? th???c hi???n th??i quen ???? ?????t ra m???i ng??y, ng?????i d??ng khi m??? app s??? tick v??o ?? vu??ng c??c th??i quen ???? th???c hi???n trong M???c To do (h??nh 1), c??c ho???t ?????ng ???? s??? ???????c chuy???n qua m???c Done ????? ????nh d???u ng?????i d??ng ???? th???c hi???n th??i quen m???i ng??y. ',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	C?? ph???n th?????ng khi ho??n th??nh nhi???m v??? v?? th??nh t???u.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	FocusAssist c??n c?? c??c th??nh t???u khi ng?????i d??ng th???c hi???n th??i quen ?????u ?????n, v???i nhi???u ??i???m th?????ng t??ng s??? h???ng th?? cho ng?????i d??ng. ????? xem c??c th??nh t???u, ng?????i d??ng c?? th??? nh???n v??o ?? Ti???n th?????ng (Gold) ????? xem c??c th??nh t???u v?? ph???n tr??m ho??n th??nh.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '3. Focus Timer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[300],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial4.PNG'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	?????m ng?????c th???i gian.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	????y l?? ch???c n??ng gi??p ng?????i d??ng t???p trung trong 1 kho???n th???i gian nh???t ?????nh, l???y ?? t?????ng t??? ph????ng ph??p ?????ng h??? Pomodoro, FocusTimer cho ph??p ng?????i d??ng ?????t th???i gian tr?????c b???ng c??ch nh???n 2 n??t t??ng v?? gi???m (^ v?? v) ????? thay ?????i th???i gian ?????m ng?????c, sau ???? nh???n n??t Play ????? th???c hi???n vi???c ?????m ng?????c v?? b???t ?????u t???p trung.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	H??? tr??? t???p trung v???i White Noise.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	????? t??ng c?????ng s??? t???p trung, ??m nh???c l?? m???t nh??n t??? r???t h???u ??ch, ch??nh v?? v???y nh???ng b??i h??t h??? tr??? t???p trung, n??ng cao tinh th???n l??m vi???c ???????c t??ch h???p s???n khi ng?????i d??ng s??? d???ng FocusTimer, ng?????i d??ng k??ch ho???t t??nh n??ng n??y b???ng c??ch nh???n n??t Music ??? g??c tr??n b??n ph???i c???a m??n h??nh FocusTimer (h??nh gi???a).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Th???ng k?? l???ch s??? s??? d???ng timer.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Ng?????i d??ng c?? th??? xem l???i nh???ng l???n s??? d???ng FocusTimer c???a m??nh v???i ch???c n??ng n??y khi nh???n v??o n??t Clock nh??? b??n g??c ph???i tr??n c??ng. Ngo??i ra c??ng c?? th??? x??a l???ch s??? b???ng c??ch nh???n n??t Delete ??? g??c tr??i tr??n c??ng trong m??n h??nh Timer history (h??nh cu???i).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	C?? ph???n th?????ng khi ho??n th??nh nhi???m v??? v?? th??nh t???u.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Khi ng?????i d??ng th???c hi???n ???????c 10 l???n,20 l???n, 50 l???n,100 l???n,.. t???p trung v???i FocusTimer, ng?????i d??ng s??? ???????c t???ng r???t nhi???u BonusGold t????ng ???ng v???i s??? l???n th???c hi???n.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '4. Focus Farm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[300],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial5.PNG'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	S??u t???m nhi???u th?? c??ng v???i nhi???u c???p ????? v?? m???c ti???n h??a kh??c nhau. Kh??ch l??? ng?????i d??ng s??? h???u th?? c??ng m???i v?? n??ng c???p th?? c??ng c??. Qu???n l?? th?? c??ng ???? s??? h???u (x??a, n??ng c???p,...). H??? th???ng c???a h??ng v???i ??a d???ng tr???ng th?? c??ng ????? ng?????i d??ng l???a ch???n.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Ng?????i d??ng c?? th??? d??ng ti???n th?????ng (Gold) t??? c??c nhi???m v??? ???? ho??n th??nh ????? mua tr???ng th?? c??ng trong c???a h??ng (h??nh 2). T???i ????y, c??c lo???i tr???ng c?? nhi???u ????? kh??c nhau v???i c??c gi?? ti???n kh??c nhau.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Sau khi mua, tr???ng s??? ???????c l??u tr??? trong Collection (h??nh 3), ng?????i d??ng c?? quy???n ch???n gi??? ho???c cho n??? (b???ng c??ch nh???n v??o qu??? tr???ng t???i m??n h??nh Collection)',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	T???i m??n h??nh ch??nh c???a n??ng tr???i (h??nh 1), ng?????i d??ng c?? th??? qu???n l?? th?? c??ng b???ng c??ch nh???n nh??? ????? n??ng c???p, ho???c nh???n ???? ????? x??a th?? c??ng.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial6.png'),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	T???ng nhi???u ph???n th?????ng khi ?????t ???????c nhi???u th?? c??ng v?? th??nh t???u.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Ng?????i d??ng s??? ???????c t???ng th??m ti???n th?????ng (bonus gold) khi s??u t???m nhi???u tr???ng v?? th?? c??ng. Danh s??ch th??nh t???u ???????c l??u ??? Achievement.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '5. Th???ng k??',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[300],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                SizedBox(height: 10,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial7.png'),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Th???ng k?? tr???c quan v???i bi???u ????? v???i c??c th??ng s??? nh?? s??? l???n th???c hi???n th??i quen, s??? l???n t???p trung, ph???n tr??m th???c hi???n c???a c??c nhi???m v???.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Th??? hi???n m???c ????? th???c hi???n qua c??c tu???n v?? t???ng qu??t. Ng?????i d??ng c?? th??? ch???n ch??? ????? so s??nh gi???a c??c tu???n b???ng Competion Rate ho???c Calendar.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '6. Setting',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                  ),
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 1,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial8.PNG'),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Qu???n l?? t??i kho???n c?? nh??n ??? Account (h??nh 4). Ng?????i d??ng c?? th??? qu???n l?? c??c ho???t ?????ng kh??c c???a t??i kho???n nh?? ?????i m???t kh???u (Change Password), X??a d??? li???u t??i kho???n (Delete All Activities) v?? X??a t??i kho???n (Delete Account), ?????i ???nh ?????i di???n,???',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	B???t, t???t th??ng b??o ???ng d???ng, thi???t l???p gi??? th??ng b??o nh???c nh??? b???ng ch???c n??ng Notification (h??nh 2).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 10,right: 10),
                                //   child: Text(
                                //     '???	Th??ng tin li??n h??? About Us s??? cung c???p th??ng tin li??n h??? v?? th??ng tin c???a c??c th??nh vi??n th???c hi???n d??? ??n.',
                                //     style: TextStyle(
                                //       //fontWeight: FontWeight.w200,
                                //       fontSize: size.height*0.023,
                                //       color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                //     ),
                                //     textAlign: TextAlign.justify,
                                //     textScaleFactor: 1,
                                //   ),
                                // ),
                                // SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Cho ph??p thay ?????i ch??? ????? giao di???n ???ng d???ng: Dark mode, Light mode.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial9.PNG'),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	B???o m???t ???ng d???ng v???i Privacy lock ??? cho ph??p ng?????i d??ng b???o m???t th??ng tin b???ng c??ch y??u c???u nh???p m???t kh???u b???o m???t ????? v??o ???ng d???ng.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 10,right: 10),
                                //   child: Text(
                                //     '???	?????i m???t kh???u.',
                                //     style: TextStyle(
                                //       //fontWeight: FontWeight.w200,
                                //       fontSize: size.height*0.023,
                                //       color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                //     ),
                                //     textAlign: TextAlign.justify,
                                //     textScaleFactor: 1,
                                //   ),
                                // ),
                                // SizedBox(height: 20,),
                                Center(
                                  child: Container(
                                    width: size.width*0.7,
                                    height: size.height*0.3,
                                    child: Image.asset('assets/achievenment/ui/tutorial10.PNG'),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '???	Th??ng tin li??n h??? About Us s??? cung c???p th??ng tin li??n h??? v?? th??ng tin c???a c??c th??nh vi??n th???c hi???n d??? ??n.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[200],
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
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
