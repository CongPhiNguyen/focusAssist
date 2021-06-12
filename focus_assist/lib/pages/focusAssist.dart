import 'package:flutter/material.dart';

import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/pages/main_screen.dart';
import 'login/screen/welcome_screen.dart';

class FocusAssist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Assist',
      home: (StaticData.isSignedIn)?MainScreen():WelcomeScreen(),
    );
  }
}




// void _show(context, String message){
//   Alert(
//     context: context,
//     type: AlertType.success,
//     title: 'Thông báo',
//     closeIcon: Icon(Icons.error),
//     desc: message,
//     buttons: [
//       DialogButton(
//         child: Text(
//           "ACCEPT",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//       )
//     ],
//   ).show();
// }

