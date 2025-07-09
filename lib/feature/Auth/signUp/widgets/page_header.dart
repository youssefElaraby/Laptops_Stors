import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Text("Welcome to our app",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
          ),
    ),
    );
  }
}
