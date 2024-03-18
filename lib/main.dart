import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whiteboardedit/whiteboard.dart';

void main() {
  runApp(TextEditorApp());
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T E X T   E D I T O R',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TextEditorScreen(),
    );
  }
}

