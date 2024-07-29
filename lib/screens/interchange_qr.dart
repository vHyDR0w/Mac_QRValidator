import 'package:flutter/material.dart';

class InterchangeQr extends StatelessWidget {
  final Widget Wbody;
  const InterchangeQr({super.key, required this.Wbody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Wbody,
    );
  }
}
