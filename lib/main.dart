import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_guide_application/Authentication/auth_gate.dart';
import 'package:tour_guide_application/consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey)
      .then((value) {
        log("Supabase Intiallized");
        runApp(const MainApp());
      })
      .onError((error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
      });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthGate());
  }
}
