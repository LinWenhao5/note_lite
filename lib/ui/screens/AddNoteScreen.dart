import 'package:flutter/material.dart';
import 'package:note_lite/models/note.dart';

import '../../services/note_service.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();
  final NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add notes")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "title"),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'content'),
            ),
            TextField(
              controller: _tagsController,
              decoration: InputDecoration(labelText: 'Tags (separated by commas)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  var note = Note(
                      title: _titleController.text,
                      content: _contentController.text,
                      createdAt: DateTime.now(),
                      updateAt: DateTime.now(),
                      tags: _tagsController.text.split(",")
                  );

                  await _noteService.addNote(note);

                  if (mounted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Save")
            )
          ],
        )
      ),
    );
  }
}