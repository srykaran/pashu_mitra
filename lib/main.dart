import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CattleManagerApp());
}

class CattleManagerApp extends StatelessWidget {
  const CattleManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cattle Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
