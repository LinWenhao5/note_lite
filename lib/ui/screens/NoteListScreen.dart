import 'package:flutter/material.dart';

import '../../models/note.dart';
import '../../services/note_service.dart';


class NoteListScreen extends StatelessWidget {
  final NoteService _noteService = NoteService();

  NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note list'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: _noteService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notes'));
          } else {
            var notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var note = notes[index];
                return ListTile(
                  title: Text(note.title ?? 'Untitled'),
                  subtitle: Text(note.content ?? 'No content'),
                  onTap: () {
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
