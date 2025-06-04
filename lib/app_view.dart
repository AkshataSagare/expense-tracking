import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,        // Fixed: background -> surface
          onSurface: Colors.black,              // Fixed: onBackground -> onSurface  
          primary: const Color(0xFF00B2E7),     // Fixed: 0*FF -> 0xFF
          secondary: const Color(0xFFE064F7),   // Fixed: 0*FF -> 0xFF
          tertiary: const Color(0xFFFF8D6C),    // Fixed: 0*FF -> 0xFF
        ),
      ),
    );
    
  }
}