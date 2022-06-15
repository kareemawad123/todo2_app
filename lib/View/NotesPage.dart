import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:note_project/View/NoteWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    print('List IN: ${list.length}');
    print('List Da: ${list}');
    return list;
  }

  Future<void> addNote(UserModel userModel) async {
    await databaseHandler!.createNote(userModel);
    print('Notes Length: ${list.length}');
  }

  Future<void> deleteNote(int id) async {
    await databaseHandler!.deleteNote(id).whenComplete(() => getNotes());
    print('Notes Length: ${list.length}');
    print('Delete Done');
  }

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );

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
        title: const Center(child: Text('To Do Home')),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff022849),
          Color(0xff016CAE),
        ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: getNotes(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? AnimationLimiter(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                list.length > checkList.length
                                    ? checkList.add(false)
                                    : print(
                                        'CheckList $index: ${checkList[index]}');
                                return list.isNotEmpty
                                    ?
                                    // DateFormat.yMMMd().format(list[index].date!)
                                    AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: Dismissible(
                                              key: ObjectKey(list[index].id),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background:
                                                  buildSwipeActionLeft(),
                                              onDismissed: (direction) {
                                                deleteNote(list[index].id!)
                                                    .whenComplete(
                                                        () => getNotes());
                                                // print('List D: ${ObjectKey(list[index].id)}');
                                                // print('List Lenght00: ${list.length}');
                                                // print('List D Id: ${list[index].id}');
                                                //   print('List Data: ${list[index]}');
                                                Get.snackbar(
                                                    'Task deleted Done', '',
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              },
                                              child: NoteWidget(
                                                noteTitle:
                                                    list[index].noteTitle!,
                                                checkBox: checkList[index],
                                                id: list[index].id,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Text('Data Empty');
                              }),
                        )
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNote(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 500));

          //Navigator.pushNamed(context, AddNote.routeName);
          print('Navigate Done');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
