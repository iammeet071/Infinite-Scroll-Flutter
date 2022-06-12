import 'package:flutter/material.dart';

class Validate extends StatelessWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = new TextEditingController();
    bool isLEngth = false;
    return Container(
      child: Center(
          child: TextField(
        controller: textEditingController,
        maxLength: 10,
      )),
    );
  }
}
