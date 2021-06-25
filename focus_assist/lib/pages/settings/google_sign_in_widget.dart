import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/user_chat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:focus_assist/pages/settings/chat_screen.dart';

import 'package:focus_assist/classes/user_chat.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  UserChat userChat;
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all((!StaticData.isDarkMode)?Colors.white:Colors.grey[800]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          handleSignIn();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/google_logo.png"),
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: (!StaticData.isDarkMode)?Colors.black54:Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> handleSignIn() async {
    setState(() {
      _isSigningIn = true;
    });

    if (await GoogleSignIn().isSignedIn()) await GoogleSignIn().disconnect();

    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User firebaseUser = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });
          userChat = UserChat(id: firebaseUser.uid, photoUrl: firebaseUser.photoURL, nickname: firebaseUser.displayName);
          onSendMessage('Hi, what can we help you with?', 0, firebaseUser.uid);
        } else {
          DocumentSnapshot documentSnapshot = documents[0];
          userChat = UserChat.fromDocument(documentSnapshot);
          print('nickname: ${userChat.nickname}');
          print('photoUrl: ${userChat.photoUrl}');
          print('id: ${userChat.id}');
        }
        Fluttertoast.showToast(msg: "Sign in success");
        this.setState(() {
          _isSigningIn = false;
        });

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(currentUserChat: userChat)));
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          _isSigningIn = false;
        });
      }
    }
    else {
      Fluttertoast.showToast(msg: "Can not init google sign in");
      this.setState(() {
        _isSigningIn = false;
      });
    }
  }

  void onSendMessage(String content, int type, String id) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      // textEditingController.clear();
      String groupChatId;
      if (id.hashCode <= 'TP31Qc1W5lQqqnRl3nertdvXk2D2'.hashCode) {
        groupChatId = '$id-${'TP31Qc1W5lQqqnRl3nertdvXk2D2'}';
      } else {
        groupChatId = '${'TP31Qc1W5lQqqnRl3nertdvXk2D2'}-$id';
      }

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': 'TP31Qc1W5lQqqnRl3nertdvXk2D2',
            'idTo': id,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      // listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    print('onSendMessage');
    // else {
    //   Fluttertoast.showToast(msg: 'Nothing to send', textColor: Colors.red);
    // }
  }

}