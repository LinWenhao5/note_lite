import 'package:flutter/material.dart';
import 'package:note_lite/ui/screens/AddNoteScreen.dart';

import '../../models/note.dart';
import '../../services/note_service.dart';


class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteService _noteService = NoteService();
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _noteService.getNotes();
  }

  void _reloadNotes() {
    setState(() {
      _notesFuture = _noteService.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note list'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNoteScreen())
              );
              _reloadNotes();
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
