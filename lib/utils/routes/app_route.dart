import 'package:flutter/cupertino.dart';
import 'package:notes_keeper/utils/routes/name_route.dart';
import 'package:notes_keeper/views/notes_details_view.dart';
import 'package:notes_keeper/views/notes_view.dart';
import 'package:notes_keeper/views/splash_view.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> approutes(
      BuildContext context) {
    return {
      RoutesName.splashView: (context) => SplashView(),
      RoutesName.notesView: (context) => NoteView(),
      RoutesName.noteDetailView: (context) => NotesDetailsView()
    };
  }
}
