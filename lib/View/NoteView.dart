import 'package:flutter/material.dart';
import 'package:note_project/View/NoteWidget.dart';
import '../Controller/DatabaseHandler.dart';
import '../Model/UserModel.dart';

class NoteView extends StatefulWidget {
  static const String routeName = 'NoteView';

  NoteView({Key? key,}) : super(key: key);
  //UserModel? note;

  @override
  State<NoteView> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteView> {
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;
  NoteArgs? args ;
  Future<void> editUser(UserModel userModel) async {
    await databaseHandler!.updateUser(userModel);
    print('Update Done');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as NoteArgs ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff016CAE),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff022849),
          Color(0xff016CAE),
        ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(30),
              child: Text(
                args!.note!.noteTitle ?? 'No Title',
                softWrap: true,
                maxLines: 10,
                textAlign: TextAlign.left,
                style: const TextStyle( fontSize: 25, color: Colors.white, fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
