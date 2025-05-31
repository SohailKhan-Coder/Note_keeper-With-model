import 'package:flutter/material.dart';
import 'package:notes_keeper/utils/routes/name_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  initState() {
    super.initState();
    splashDelay();
  }

  splashDelay() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(RoutesName.notesView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome To Notes Keeper",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
