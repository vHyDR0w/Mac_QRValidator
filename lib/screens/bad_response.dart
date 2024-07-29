import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class BadResponse extends StatelessWidget {
  const BadResponse({super.key});

  @override
  Widget build(BuildContext context) {
    //In case of wrong QR scanned, this page is invoked
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: const Center(
        child: Text(
          'Invalid QR',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
