import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_lite/models/note.dart';

class NoteService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = "notes";

  // Get all notes
  Future<List<Note>> getNotes() async {
    var result = await _db.collection(collectionName).get();
    return result.docs
        .map((doc) => Note.fromFireStore(doc.data()))
        .toList();
  }

  // Add Notes
  Future<void> addNote(Note note) async {
    await _db.collection(collectionName).add(note.toMap());
  }

  // Update Note
  Future<void> updateNote(String id, Note note) async {
    await _db.collection(collectionName).doc(id).update(note.toMap());
  }

  // Delete Note
  Future<void> deleteNote(String id) async {
    await _db.collection(collectionName).doc(id).delete();
  }
}