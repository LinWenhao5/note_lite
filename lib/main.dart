import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_lite/screens/NoteListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NoteLite());
}
class NoteLite extends StatelessWidget {
  const NoteLite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Note Lite",
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: NoteListScreen()
    );
  }
}