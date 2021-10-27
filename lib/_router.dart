import 'package:flutter/material.dart';
import 'package:mtime_mordre/home.dart';
import 'package:mtime_mordre/models/Departments_collection.dart';
import 'package:mtime_mordre/onboarding.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';
import 'models/Bil.dart';

class MWork extends StatelessWidget {
  const MWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        Provider(create: (context) => DepartmentsModel()),
      ],
      child: MaterialApp(
        title: 'mWork',
        theme: appTheme,
        initialRoute: '/onboarding',
        routes: {
          '/': (context) => const HomePage(title: 'mWork'),
          '/onboarding': (context) => const Onboarding(title: 'Velkommen'),
        },
      ),
    );
  }
}