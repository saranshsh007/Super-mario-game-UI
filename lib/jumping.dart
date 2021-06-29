import 'package:flutter/material.dart';
import 'dart:math';

class jumpingmario extends StatelessWidget {

  final direction;
  final size;

  jumpingmario({this.direction, this.size});

  @override
  Widget build(BuildContext context) {
    if(direction == "right"){
      return Container(
          width: size,
          height: size,
          child: Image.asset('lib/images/jumpingmario.png')
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
            width: size,
            height: size,
            child: Image.asset('lib/images/jumpingmario.png')
        ),
      );
    }
  }
}
