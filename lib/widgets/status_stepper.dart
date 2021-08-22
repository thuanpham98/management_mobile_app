import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StepperText {
  final String? doingText;
  final String? doneText;
  final Widget? doingIcon;
  final Widget? doneIcon;

  StepperText({this.doingText, this.doneText, this.doingIcon, this.doneIcon});
}

class StatusStepper extends StatelessWidget {
  final List<StepperText> steps;
  final int selected;

  StatusStepper({this.steps = const [], this.selected = 0});

  Widget _buildStepper(BuildContext context, int step) {
    List<Widget> widget = [];

    for (var i = 0; i < steps.length; i++) {
      if (i == step) {
        widget.add(FlatButton.icon(
            onPressed: () {},
            icon: steps[i].doingIcon ??
                SpinKitThreeBounce(
                  color: Theme.of(context).textSelectionColor,
                  size: 20,
                ),
            label: Text(steps[i].doingText!,
                style: Theme.of(context).textTheme.bodyText2)));
      } else if (i < step) {
        widget.add(FlatButton.icon(
            onPressed: () {},
            icon: steps[i].doneIcon ??
                Icon(
                  Icons.check,
                  color: Theme.of(context).textSelectionColor,
                ),
            label: Text(
              steps[i].doneText!,
              style: TextStyle(
                color: Theme.of(context).textSelectionColor,
              ),
            )));
      }
    }
    return Column(children: widget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepper(context, selected);
  }
}
