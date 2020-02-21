import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final int value;

  Block({this.value});

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceOut,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 0.02),
        color: Colors.white24,
      ),
      child: Center(child: Text("${widget.value}", style: TextStyle(fontSize: 20.0),),),
    );
  }
}