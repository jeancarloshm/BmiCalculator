import 'package:flutter/material.dart';

class AwesomeCard extends StatelessWidget {
  const AwesomeCard({
    Key? key,
    required this.color,
    required this.icon,
    this.onPress,
  }) : super(key: key);

  final Color color;
  final Widget icon;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 200.0,
        width: 170.0,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: icon,
      ),
    );
  }
}
