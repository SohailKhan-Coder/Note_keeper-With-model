import 'package:flutter/cupertino.dart';

import '../model/note_model.dart';
import '../services/db_helper.dart';

class NoteViewModel extends ChangeNotifier {
  final _databaseHelper = DatabaseHelper.instance;

  List<String> priorityList = ['High', 'Low'];

  List<NoteModel> _noteList = [];
  List<NoteModel> get noteList => _noteList;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorText;
  String? get errorText => _errorText;

  //Priority as a integer
  int _priority = 2;
  int get priority => _priority;

  void priorityAsInt(String value) {
    switch (value) {
      case 'High':
        _priority = 1;
      case 'Low':
        _priority = 2;
    }
    notifyListeners();
  }

  NoteViewModel() {
    fetchData();
  }

  NoteModel? noteModel;

  ///Get Priority as String
  String priorityAsString(int value) {
    String stringPriority;
    switch (value) {
      case 1:
        stringPriority = 'High';
        return stringPriority;
      case 2:
        stringPriority = 'Low';
        return stringPriority;
      default:
        stringPriority = 'Low';
        return stringPriority;
    }
  }

  Future<void> fetchData() async {
    _loading = true;
    notifyListeners();
    try {
      _noteList = await _databaseHelper.fetchData();
      _errorText = null;
      notifyListeners();
    } catch (e) {
      _errorText = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
///Insertion of Notes
  Future<void> insertData(NoteModel noteModel) async {
    try {
      _databaseHelper.insertion(noteModel);
      await fetchData();
    } catch (e) {
      _errorText = e.toString();
      notifyListeners();
    }
  }
///Deletion of Notes
  Future<void> deleteNote(int id) async {
    try {
      await _databaseHelper.deletion(id);
      await fetchData();
    } catch (e) {
      _errorText = e.toString();
      notifyListeners();
    }
  }
///Editing of Notes
  Future<void> updateNote(NoteModel noteModel) async {
    try {
      await _databaseHelper.updation(noteModel);
      await fetchData();
    } catch (e) {
      _errorText = e.toString();
      notifyListeners();
    }
  }
}
