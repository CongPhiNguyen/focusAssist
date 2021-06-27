import 'package:flutter/material.dart';


class edit_text extends StatelessWidget {
  final Widget child;
  const edit_text({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(
            color: Colors.amber[200],
            blurRadius: 10.0,
            offset: Offset(1,5),
          )]
      ),
      child: child,
    );
  }
}