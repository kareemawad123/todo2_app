import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_project/View/EditNote.dart';
import 'package:note_project/View/NoteView.dart';
import '../Controller/DatabaseHandler.dart';
import '../Model/UserModel.dart';

class NoteArgs {
  UserModel? note;

  NoteArgs(this.note);
}

class NoteWidget extends StatefulWidget {
  NoteWidget({
    Key? key,
    required this.noteTitle,
    required this.checkBox,
    required this.id,
  }) : super(key: key);
  final String? noteTitle;
  late bool? checkBox;
  final int? id;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  DatabaseHandler? databaseHandler = DatabaseHandler.instance;
  UserModel? note;

  Future<UserModel> getOneUser() async {
    note = await databaseHandler!.getOneUsers(widget.id!);
    print('Get One User Done');
    print('Title: ${note!.noteTitle}');
    return note!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getOneUser().whenComplete(() => {
              Get.to(() => NoteView(),
                  arguments: NoteArgs(note!),
                  transition: Transition.size,
                  duration: const Duration(milliseconds: 500))
            });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          //color: Color(0xff004D80),
          gradient: LinearGradient(
              colors: [const Color(0xff004D7F), Colors.blue.shade900],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    activeColor: Colors.blue,
                    focusColor: Colors.white,
                    checkColor: Colors.white,
                    value: widget.checkBox,
                    onChanged: (value) {
                      setState(() {
                        widget.checkBox = value!;
                        print('CheckBoxxx: ${widget.checkBox}');
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.noteTitle!,
                    style: widget.checkBox!
                        ? const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            decorationColor: Colors.white,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 2,
                            decoration: TextDecoration.lineThrough,
                          )
                        : const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          ) ,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      getOneUser().whenComplete(() => {
                        Get.to(() => NoteEdit(),
                            arguments: NoteArgs(note!),
                            transition: Transition.size,
                            duration: const Duration(milliseconds: 500))
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
