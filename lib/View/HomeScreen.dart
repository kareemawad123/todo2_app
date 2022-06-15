import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Controller/DatabaseHandler.dart';
import '../Model/UserModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  //Future? future;
  List<UserModel> list = [];
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;

  Future<List<UserModel>> getNotes() async {
    list = await databaseHandler!.getAllNotes();
    return list;
  }

  Future<void> addNote(UserModel userModel) async {
    await databaseHandler!.createNote(userModel);
    print('Notes Length: ${list.length}');
  }

  Future<void> deleteUser(int id) async {
    await databaseHandler!.deleteNote(id);
    print('Notes Length: ${list.length}');
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              /// Name Text Field
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              /// phone Text Field
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: 'Enter Data',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              /// Add Button
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        addNote(UserModel(
                          noteTitle: titleController.text,
                          date: DateTime.now(),
                        )).then((value) {
                          setState(() {
                            getNotes();
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))),

              /// Delete Button
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        deleteUser(list[0].id!).then((value) {
                          setState(() {
                            getNotes();
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))),

              /// View Users
              FutureBuilder(
                future: getNotes(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return list.isNotEmpty
                                ? Column(
                                    children: <Widget>[
                                      Text(list[index].noteTitle!),
                                      Text(
                                        DateFormat.yMMMd()
                                            .format(list[index].date!),
                                      ),
                                    ],
                                  )
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
