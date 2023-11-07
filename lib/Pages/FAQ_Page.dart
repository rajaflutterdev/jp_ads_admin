import 'package:flutter/cupertino.dart';

class FAQ_Page extends StatefulWidget {
  const FAQ_Page({super.key});

  @override
  State<FAQ_Page> createState() => _FAQ_PageState();
}

class _FAQ_PageState extends State<FAQ_Page> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("FAQ Page")
      ],
    );
  }
}
