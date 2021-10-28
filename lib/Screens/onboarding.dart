
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtime_mordre/Screens/home.dart';
import 'package:mtime_mordre/widgets/pick_department.dart';
import 'package:mtime_mordre/widgets/snackbar.dart';
import 'package:mtime_mordre/widgets/stepper.dart';
import '../Services/api_service.dart';
import '../models/Bil.dart';

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
    //return PickDepartment();
    return OnboardingStepper();
  }


}


