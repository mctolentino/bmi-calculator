import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_content.dart';
import 'reusable_card.dart';

class InputPage extends StatefulWidget {
  InputPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InputPageState createState() => _InputPageState();
}

enum Gender { MALE, FEMALE }

const double bottomContainerHeight = 60;
const Color activeCardColor = Color(0xFF1D1E33);
const Color inactiveCardColor = Color(0xFF111328);
const Color bottomContainerColor = Color(0xFFEB1555);

class _InputPageState extends State<InputPage> {
  Color maleCardColor = inactiveCardColor;
  Color femaleCardColor = inactiveCardColor;

  void updateColor(Gender gender) {
    if (gender == Gender.MALE) {
      maleCardColor = maleCardColor == inactiveCardColor
          ? activeCardColor
          : inactiveCardColor;
      femaleCardColor = inactiveCardColor;
    }
    if (gender == Gender.FEMALE) {
      femaleCardColor = femaleCardColor == inactiveCardColor
          ? activeCardColor
          : inactiveCardColor;
      maleCardColor = inactiveCardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          updateColor(Gender.MALE);
                        });
                      },
                      child: ReusableCard(
                        color: maleCardColor,
                        cardChild: IconContent(
                            icon: FontAwesomeIcons.mars, label: 'MALE'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          updateColor(Gender.FEMALE);
                        });
                      },
                      child: ReusableCard(
                          color: femaleCardColor,
                          cardChild: IconContent(
                              icon: FontAwesomeIcons.venus, label: 'FEMALE')),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(color: activeCardColor),
                ),
              ],
            )),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(color: activeCardColor),
                  ),
                  Expanded(
                    child: ReusableCard(color: activeCardColor),
                  ),
                ],
              ),
            ),
            Container(
              color: bottomContainerColor,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: bottomContainerHeight,
            )
          ],
        ));
  }
}
