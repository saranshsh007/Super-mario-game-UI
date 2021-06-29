import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final child;
  final function;
  static bool holdingButton = false;

  Button({this.child, this.function});

  bool userIsHoldingButton(){
    return holdingButton;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:(details){
        holdingButton = true;
        function();
      },
      onTapUp: (details){
        holdingButton = false;
        },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.green,
          child: child,

        ),
      ),
    );
  }
}
