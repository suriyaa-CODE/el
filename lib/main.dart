import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'services/voice_service.dart';
import 'services/election_assistant_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => VoiceService())],
      child: const ElectionAssistantApp(),
    ),
  );
}

class ElectionAssistantApp extends StatelessWidget {
  const ElectionAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Election Assistant',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      ),
      home: const ElectionAssistantScreen(),
    );
  }
}
