
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/Screens/screen_home.dart';
import 'package:mtime_mordre/widgets/widget_pick_department.dart';
import 'package:mtime_mordre/widgets/widget_snackbar.dart';
import 'package:mtime_mordre/widgets/widget_stepper.dart';
import '../services/api_service.dart';
import '../models/model_car.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key, required this.title, }) : super(key: key);
  final String title;

  @override
  _Onboarding createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _onboarding(context);
  }

  Widget _onboarding(BuildContext context) {
    return OnboardingStepper();
  }


}


