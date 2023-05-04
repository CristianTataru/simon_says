import 'package:flutter/material.dart';
import 'package:simon_game/play_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: PlayPage(),
          ),
        ),
      ),
    ),
  );
}
