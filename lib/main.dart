import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';
import 'Screens/investments_screen.dart';
import 'Screens/income_screen.dart';
import 'Screens/performance_screen.dart';
import 'Screens/projections_screen.dart';
import 'Screens/alerts_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/splash_screen.dart';
import 'Screens/chat_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const EconFlowApp());
}

class EconFlowApp extends StatelessWidget {
  const EconFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECONFLOW.IA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const HomeScreen(),
        '/investments': (context) => const InvestmentsScreen(),
        '/income': (context) => const IncomeScreen(),
        '/performance': (context) => const PerformanceScreen(),
        '/projections': (context) => const ProjectionsScreen(),
        '/alerts': (context) => const AlertsScreen(),
          '/chat': (context) => const ChatScreen(),
      },
    );
  }
}