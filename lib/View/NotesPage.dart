import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_project/View/NoteWidget.dart';
import 'package:provider/provider.dart';

import '../Controller/DatabaseHandler.dart';
import '../Controller/ProviderController.dart';
import '../Model/UserModel.dart';
import 'AddNewNote.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<UserModel> list = [];
  List<bool> checkList = [];
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;

  Future<List<UserModel>> getNotes() async {
    list = await databaseHandler!.getAllNotes();
    return list;
  }

  Future<void> addNote(UserModel userModel) async {
    await databaseHandler!.createNote(userModel);
    print('Notes Length: ${list.length}');
  }
  Future<void> deleteNote(int id) async {
    await databaseHandler!.deleteNote(id);
    print('Notes Length: ${list.length}');
    print('Done Delll');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    databaseHandler!.database;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Color(0xff022849),
      appBar: AppBar(
        backgroundColor: const Color(0xff016CAE),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff022849),
          Color(0xff016CAE),
        ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: getNotes(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      list.length > checkList.length ? checkList.add(false) :
                      print('CheckList Length: ${checkList.length}');
                      print('list Length: ${list.length}');
                      return list.isNotEmpty?
                      // DateFormat.yMMMd().format(list[index].date!)
                          NoteWidget(noteTitle: list[index].noteTitle!, noteData: list[index].noteData!,checkBox: checkList[index],id: list[index].id,)
                          : const Text('Data Empty');
                    })
                    : snapshot.hasError
                    ? const Text('Error')
                    : Column(
                  children: [
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height * 0.15,
                    ),
                    const CircularProgressIndicator(),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: IconButton(
                  onPressed: (){

                    // setState(() {
                    //   deleteNote(list[0].id!);
                    // });
                    Navigator.pushNamed(context, AddNote.routeName);
                  },
                  icon: const Icon(Icons.add,color: Color(0xff016CAE),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
