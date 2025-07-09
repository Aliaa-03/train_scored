import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/forms/score_card.dart';
import 'screens/forms/coach_cleaning.dart';
import 'screens/forms/chemicals.dart';
import 'screens/forms/staff_consumables.dart';
import 'screens/forms/bpb_stations.dart';
import 'screens/forms/payment_or_platform.dart';

import 'provider/form_data_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Card App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/forms/score_card': (context) => ScoreCardForm(),
        '/forms/coach_cleaning': (context) => CoachCleaningForm(),
        '/forms/chemicals': (context) => ChemicalsForm(),
        '/forms/staff_consumables': (context) => StaffConsumablesForm(),
        '/forms/bpb_stations': (context) => BpbStationsForm(),
        '/forms/payment_or_platform': (context) => PaymentOrPlatformForm(),
      },
    );
  }
}
