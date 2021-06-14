import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';


class design_appbar_shop extends StatefulWidget {
  final Size size;

  const design_appbar_shop({Key key, this.size}) : super(key: key);
  @override
  _design_appbar_shopState createState() => _design_appbar_shopState(size);
}

class _design_appbar_shopState extends State<design_appbar_shop> {
  final Size size;
  int vang;
  _design_appbar_shopState(this.size);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vang =StaticData.Vang;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      child: Container(
        width: size.width,
        height: size.height*0.2,
        decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
        child: Image.asset('assets/achievenment/ui/ui_shop.PNG'),
      ),
    );
  }
}
