import 'Constant.dart';

class UserModel {
  final int? id;
  final String? noteTitle;
  final String? noteData;
  final DateTime? date;


  UserModel({this.id, this.noteTitle, this.noteData, this.date});

  Map<String, dynamic> toMap() {
    return {
      columnNoteTitle: noteTitle,
      columnNoteData: noteData,
      columnDate: date?.toIso8601String(),
    };
  }
  Map<String, dynamic> toMapUpdate() {
    return {
      columnNoteTitle: noteTitle,
      columnNoteData: noteData,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[columnId],
      noteTitle: map[columnNoteTitle],
      noteData: map[columnNoteData],
      date: DateTime.parse(map[columnDate]as String),
    );
  }
}
