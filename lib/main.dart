import 'package:flutter/material.dart';
import 'package:note_project/View/AddNewNote.dart';
import 'package:note_project/View/EditNote.dart';
import 'package:provider/provider.dart';

import 'Controller/ProviderController.dart';
import 'View/NotesPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderController(),
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          NoteEdit.routeName: (context) => NoteEdit(note: null,),
          AddNote.routeName: (context) => const AddNote(),
        },
        home: const NotesPage(),
      ),
    );
  }
}
