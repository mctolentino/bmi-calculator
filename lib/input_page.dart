import 'package:bmi_calculator/bottom_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/results_page.dart';
import 'package:bmi_calculator/round_icon_button.dart';
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

class _InputPageState extends State<InputPage> {
  Gender _selectedGender;
  int _height = 180;
  int _weight = 60;
  int _age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          _selectedGender = Gender.MALE;
                        });
                      },
                      color: _selectedGender == Gender.MALE
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      cardChild: IconContent(
                          icon: FontAwesomeIcons.mars, label: 'MALE'),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            _selectedGender = Gender.FEMALE;
                          });
                        },
                        color: _selectedGender == Gender.FEMALE
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                            icon: FontAwesomeIcons.venus, label: 'FEMALE')),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'HEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: <Widget>[
                            Text(_height.toString(), style: kNumberTextStyle),
                            Text('cm', style: kLabelTextStyle),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Color(0xFF8D8E98),
                                  thumbColor: Color(0xFFEB1555),
                                  overlayColor: Color(0x30EB1555),
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 15.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 30.0)),
                              child: Slider(
                                value: _height.toDouble(),
                                min: 100.0,
                                max: 250.0,
                                onChanged: (double val) {
                                  setState(() {
                                    _height = val.round();
                                  });
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                        color: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('WEIGHT', style: kLabelTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  _weight.toString(),
                                  style: kNumberTextStyle,
                                ),
                                Text(
                                  'kg',
                                  style: kLabelTextStyle,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      _weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      _weight++;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: ReusableCard(
                        color: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('AGE', style: kLabelTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  _age.toString(),
                                  style: kNumberTextStyle,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      _age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      _age++;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultsPage()));
              },
              child: BottomButton(
                label: 'CALCULATE',
                onPress: () {
                  CalculatorBrain cb =
                      CalculatorBrain(height: _height, weight: _weight);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultsPage(
                        bmi: cb.calculateBMI(),
                        result: cb.getResult(),
                        interpretation: cb.getInterpretation());
                  }));
                },
              ),
            )
          ],
        ));
  }
}
