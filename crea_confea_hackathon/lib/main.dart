import 'package:crea_confea_hackathon/pages/ART_facil/ART_facil_page.dart';
import 'package:crea_confea_hackathon/pages/ART_facil/pagina.dart';
import 'package:crea_confea_hackathon/pages/register/register_page.dart';
import 'package:crea_confea_hackathon/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xffF7F8F9),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
      home: const ArtFacilPage(),
    );
  }
}
