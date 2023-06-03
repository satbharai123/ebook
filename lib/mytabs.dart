import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  final Color color;
  final String text;
  const MyTabs({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      height: 50, width: 120,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
            )
          ]
      ),
      child: Center(
        child: Text(this.text, style: TextStyle(
            color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,

        ),),
      ),

    );
  }
}
