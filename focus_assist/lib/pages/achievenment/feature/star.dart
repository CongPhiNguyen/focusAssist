import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int Sao;


  const RatingStar({Key key, this.Sao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(Sao, (index){
        return Icon(
          Icons.star,
          color: Colors.white,
          size: 16,
        );
      }),
    );
  }
}