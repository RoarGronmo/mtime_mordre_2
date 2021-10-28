import 'package:flutter/material.dart';
import 'package:mtime_mordre/widgets/pick_department.dart';

class OnboardingStepper extends StatefulWidget {
  @override
  _OnboardingStepperState createState() => _OnboardingStepperState();
}

class _OnboardingStepperState extends State<OnboardingStepper> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;


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
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Velg bil'),
                    content: Column(
                      children: <Widget>[
                        PickDepartment()
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
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
                    state: _currentStep >= 1 ?
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
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),

    );
  }
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
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