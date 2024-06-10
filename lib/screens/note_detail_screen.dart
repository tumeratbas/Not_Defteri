import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final int noteId;

  NoteDetailScreen({required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Detail'),
      ),
      body: Center(
        child: Text('Details for Note $noteId'),
      ),
    );
  }
}
