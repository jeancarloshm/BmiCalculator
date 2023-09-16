import 'dart:developer';

import 'package:bmi_calculator/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'calculator.dart';
import 'constants.dart';
import 'icon_content.dart';
import 'results_page.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<InputPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<InputPage> {
  Gender? selectedGender;
  late int height;
  late int weight;
  late int age;

  @override
  void initState() {
    super.initState();
    selectedGender = null;
    height = 120;
    weight = 65;
    age = 18;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AwesomeCard(
                  color: selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  icon: const IconContent(
                      icon: FontAwesomeIcons.mars, label: 'MALE'),
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                ),
                AwesomeCard(
                  color: selectedGender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  icon: const IconContent(
                      icon: FontAwesomeIcons.venus, label: 'FEMALE'),
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AwesomeCard(
                  color: kActiveCardColour,
                  icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'HEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              height.toString(),
                              style: kNumberTextStyle,
                            ),
                            const Text(
                              'cm',
                              style: kLabelTextStyle,
                            )
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            inactiveTrackColor: const Color(0xFF8D8E98),
                            activeTrackColor: Colors.white,
                            thumbColor: const Color(0xFFEB1555),
                            overlayColor: const Color(0x29EB1555),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 15.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 30.0),
                          ),
                          child: Slider(
                            min: 120,
                            max: 220,
                            value: height.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                height = value.round();
                              });
                            },
                          ),
                        )
                      ]),
                  onPress: () {},
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AwesomeCard(
                  color: kActiveCardColour,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'WEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          const Text(
                            'kg',
                            style: kLabelTextStyle,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyWeightButton(
                            icon: FontAwesomeIcons.minus,
                            onPress: () {
                              setState(() {
                                if (weight == 0) return;

                                weight--;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          MyWeightButton(
                            icon: FontAwesomeIcons.plus,
                            onPress: () {
                              setState(() {
                                if (weight == 300) return;
                                weight++;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  onPress: () {},
                ),
                AwesomeCard(
                  color: kActiveCardColour,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyWeightButton(
                            icon: FontAwesomeIcons.minus,
                            onPress: () {
                              setState(() {
                                if (age == 18) return;

                                age--;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          MyWeightButton(
                            icon: FontAwesomeIcons.plus,
                            onPress: () {
                              setState(() {
                                if (age == 100) return;

                                age++;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  onPress: () {},
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.getBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyWeightButton extends StatelessWidget {
  MyWeightButton({super.key, required this.icon, required this.onPress});

  IconData icon;
  void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        elevation: 0.0,
        onPressed: onPress,
        constraints: const BoxConstraints.tightFor(height: 56.0, width: 56.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        fillColor: const Color(0xFF4C4F5E),
        child: Icon(icon));
  }
}
