import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/flower_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const FlowerApp());
}

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '花城志',
      debugShowCheckedModeBanner: false,
      theme: FlowerTheme.theme,
      home: const HomeScreen(),
    );
  }
}
