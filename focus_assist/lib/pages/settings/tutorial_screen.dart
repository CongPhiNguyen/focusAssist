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
                                  '1. Quản lý tải khoản',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: Colors.black,
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
                                    '•	Đăng ký và đăng nhập: Để tạo tài khoản mới, tại màn hình Đăng nhập, người dùng nhấn nút SIGN UP, sau đó điền thông tin bao gồm Name, Username và Password, Sau đó tiến hành đăng nhập tại màn hình Login.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
                                    '•	Tìm lại mật khẩu: Dùng những câu trả lời của QuestionScreen để giúp bạn lấy lại mật khẩu.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '2. Quản lý các thói quen',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: Colors.black,
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
                                    '•	Trong màn hình này, người dùng có thể tạo, chỉnh sửa, xóa, phân loại thói quen. .',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Để tạo thói quen mới, người dùng nhấn vào nút (+) ở góc phải màn hình, sau đó tiến hành nhập tên thói quen (Activity Name), Mô tả (Description), Ngày bắt đầu (Start Day), Nhóm thói quen (Group, dùng để phân loại các thói quen) và cuối cùng là lựa chọn lặp lại thói quen gồm 3 chế độ: Fixed, Flexible và Repeating. Trong đó chế độ Fixed cho phép người dùng lặp lại thói quen ở các ngày nhất định trong tuần, chế độ Flexible cho phép người dùng chọn lặp lại theo số ngày trong tuần và cuối cùng là Repeating cho phép thông báo thói quen bằng cách lặp lại cách mỗi N ngày.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Theo dõi thói quen bằng biểu đồ thống kê..',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Để theo dõi quá trình thực hiện của 1 thói quen, người dùng có thể ấn vào một hoạt động bất kì trên màn hình chính, tại màn hình theo dõi (màn hình 3) sẽ cho phép người dùng xem chi tiết quá trình thực hiện thói quen mỗi ngày và thống kê tiến độ thực hiện của hoạt động đó bằng biểu đồ tròn. Ngoài ra người dùng còn có thể xóa thói quen hoặc chỉnh sửa thói quen bằng các tiện ích ở trên cùng màn hình.',                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Thông báo, nhắc nhở hằng ngày.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Để thực hiện thói quen đã đặt ra mỗi ngày, người dùng khi mở app sẽ tick vào ô vuông các thói quen đã thực hiện trong Mục To do (hình 1), các hoạt động đó sẽ được chuyển qua mục Done để đánh dấu người dùng đã thực hiện thói quen mỗi ngày. ',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Có phần thưởng khi hoàn thành nhiệm vụ và thành tựu.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	FocusAssist còn có các thành tựu khi người dùng thực hiện thói quen đều đặn, với nhiều điểm thưởng tăng sự hứng thú cho người dùng. Để xem các thành tựu, người dùng có thể nhấn vào ô Tiền thường (Gold) để xem các thành tựu và phần trăm hoàn thành.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
                                    color: Colors.black,
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
                                    '•	Đếm ngược thời gian.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Đây là chức năng giúp người dùng tập trung trong 1 khoản thời gian nhất định, lấy ý tưởng từ phương pháp đồng hồ Pomodoro, FocusTimer cho phép người dùng đặt thời gian trước bằng cách nhấn 2 nút tăng và giảm (^ và v) để thay đổi thời gian đếm ngược, sau đó nhấn nút Play để thực hiện việc đếm ngược và bắt đầu tập trung.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Hỗ trợ tập trung với White Noise.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Để tăng cường sự tập trung, âm nhạc là một nhân tố rất hữu ích, chính vì vậy những bài hát hỗ trợ tập trung, nâng cao tinh thần làm việc được tích hợp sẵn khi người dùng sử dụng FocusTimer, người dùng kích hoạt tính năng này bằng cách nhấn nút Music ở góc trên bên phải của màn hình FocusTimer (hình giữa).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Thống kê lịch sử sử dụng timer.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Người dùng có thể xem lại những lần sử dụng FocusTimer của mình với chức năng này khi nhấn vào nút Clock nhỏ bên góc phải trên cùng. Ngoài ra cũng có thể xóa lịch sử bằng cách nhấn nút Delete ở góc trái trên cùng trong màn hình Timer history (hình cuối).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Có phần thưởng khi hoàn thành nhiệm vụ và thành tựu.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Khi người dùng thực hiện được 10 lần,20 lần, 50 lần,100 lần,.. tập trung với FocusTimer, người dùng sẽ được tặng rất nhiều BonusGold tương ứng với số lần thực hiện.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '4. Focus Famer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: Colors.black,
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
                                    '•	Sưu tầm nhiều thú cưng với nhiều cấp độ và mức tiến hóa khác nhau. Khích lệ người dùng sở hữu thú cưng mới và nâng cấp thú cưng cũ. Quản lý thú cưng đã sở hữu (xóa, nâng cấp,...). Hệ thống cửa hàng với đa dạng trứng thú cưng để người dùng lựa chọn.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Người dùng có thể dùng tiền thưởng (Gold) từ các nhiệm vụ đã hoàn thành để mua trứng thú cưng trong cửa hàng (hình 2). Tại đây, các loại trứng có nhiều độ khác nhau với các giá tiền khác nhau.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Sau khi mua, trứng sẽ được lưu trữ trong Collection (hình 3), người dùng có quyền chọn giữ hoặc cho nở (bằng cách nhấn vào quả trứng tại màn hình Collection)',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Tại màn hình chính của nông trại (hình 1), người dùng có thể quản lý thú cưng bằng cách nhấn nhẹ để nâng cấp, hoặc nhấn đè để xóa thú cưng.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
                                    '•	Tặng nhiều phần thưởng khi đạt được nhiều thú cưng và thành tựu.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.only(left: 40,right: 10),
                                  child: Text(
                                    '-	Người dùng sẽ được tặng thêm tiền thưởng (bonus gold) khi sưu tầm nhiều trứng và thú cưng. Danh sách thành tựu được lưu ở Achievement.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  '5. Thống kê',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.03,
                                    color: Colors.black,
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
                                    '•	Thống kê trực quan với biểu đồ với các thông số như số lần thực hiện thói quen, số lần tập trung, phần trăm thực hiện của các nhiệm vụ.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Thể hiện mức độ thực hiện qua các tuần và tổng quát. Người dùng có thể chọn chế độ so sánh giữa các tuần bằng Competion Rate hoặc Calendar.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
                                    color: Colors.black,
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
                                    '•	Quản lý tài khoản cá nhân – Account (hình 4). Người dùng có thể quản lý các hoạt động khác của tài khoản như Đổi mật khẩu (Change Password), Xóa dữ liệu tài khoản (Delete All Activities) và Xóa tài khoản (Delete Account), Đổi Ảnh đại diện,…',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Bật, tắt thông báo ứng dụng, thiết lập giờ thông báo nhắc nhở bằng chức năng Notification (hình 2).',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 10,right: 10),
                                //   child: Text(
                                //     '•	Thông tin liên hệ About Us sẽ cung cấp thông tin liên hệ và thông tin của các thành viên thực hiện dự án.',
                                //     style: TextStyle(
                                //       //fontWeight: FontWeight.w200,
                                //       fontSize: size.height*0.023,
                                //       color: Colors.black,
                                //     ),
                                //     textAlign: TextAlign.justify,
                                //     textScaleFactor: 1,
                                //   ),
                                // ),
                                // SizedBox(height: 15,),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(
                                    '•	Cho phép thay đổi chủ đề giao diện ứng dụng: Dark mode, Light mode.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
                                    '•	Bảo mật ứng dụng với Privacy lock – cho phép người dùng bảo mật thông tin bằng cách yêu cầu nhập mật khẩu bảo mật để vào ứng dụng.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 10,right: 10),
                                //   child: Text(
                                //     '•	Đổi mật khẩu.',
                                //     style: TextStyle(
                                //       //fontWeight: FontWeight.w200,
                                //       fontSize: size.height*0.023,
                                //       color: Colors.black,
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
                                    '•	Thông tin liên hệ About Us sẽ cung cấp thông tin liên hệ và thông tin của các thành viên thực hiện dự án.',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w200,
                                      fontSize: size.height*0.023,
                                      color: Colors.black,
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
