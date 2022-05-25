
import 'package:flutter/material.dart';

import '../Controller/DatabaseHandler.dart';
import '../Model/UserModel.dart';

class AddNote extends StatefulWidget {
  static const String routeName = 'NoteEdit';
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;

  Future<void> addUser(UserModel userModel) async {
    await databaseHandler!.createNote(userModel);
    print('Add User Done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff022849),
              Color(0xff016CAE),
            ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Note Title',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: dataController,
                decoration: InputDecoration(
                  hintText:  'Note Data',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            /// Edit Button
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      addUser(UserModel(
                        noteTitle: titleController.text,
                        noteData: dataController.text,
                        date: DateTime.now(),
                      ));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40)),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ))),
          ],
        ),
      ),
    );
  }
}
