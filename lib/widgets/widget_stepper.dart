import 'package:flutter/material.dart';
import 'package:mtime_mordre/widgets/widget_pick_department.dart';
import 'package:mtime_mordre/widgets/widget_pick_office.dart';

class OnboardingStepper extends StatefulWidget {
  @override
  _OnboardingStepperState createState() => _OnboardingStepperState();
}

class _OnboardingStepperState extends State<OnboardingStepper> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Onboarding'),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Velg Kontor'),
                    content: Column(
                      children: <Widget>[
                        PickOffice()
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Velg bil'),
                    content: Column(
                      children: <Widget>[
                        PickDepartment()
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Annet 1'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Annet 2'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Annet 3'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Annet'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Annet 4'),
                        ),
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 3 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }


  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
}