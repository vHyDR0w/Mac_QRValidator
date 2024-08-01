import 'package:flutter/material.dart';

Widget emptyFeed() {
  return const Center(
    child: Text(
      'Not a single feed yet.',
      style: TextStyle(fontSize: 20),
    ), // Show a loading indicator while navigating
  );
}
