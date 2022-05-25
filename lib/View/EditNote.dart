import 'package:flutter/material.dart';
import '../Controller/DatabaseHandler.dart';

import '../Model/UserModel.dart';

class NoteEdit extends StatefulWidget {
  static const String routeName = 'NoteEdit';

   NoteEdit({Key? key, required this.note}) : super(key: key);
  UserModel? note;
  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;

  Future<void>editUser(UserModel userModel)async{
    await databaseHandler!.updateUser(userModel);
    print('Update Done');
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    titleController.dispose();
    dataController.dispose();
    super.dispose();
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
                  hintText: widget.note!.noteTitle ?? 'No Title',
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
                  hintText: widget.note!.noteData ?? 'No Data',
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
                      editUser(UserModel(
                        noteTitle: titleController.text,
                        noteData: dataController.text,
                        id: widget.note!.id
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