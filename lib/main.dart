import 'package:flutter/material.dart';
import 'package:notes_keeper/utils/routes/app_route.dart';
import 'package:notes_keeper/utils/routes/name_route.dart';
import 'package:notes_keeper/view_model/note_view_model.dart';
import 'package:notes_keeper/views/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:  (context)=> NoteViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
              backgroundColor: Colors.indigo, foregroundColor: Colors.white),
        ),
        initialRoute: RoutesName.splashView,
        routes: AppRoutes.approutes(context),
      ),
    );
  }
}
