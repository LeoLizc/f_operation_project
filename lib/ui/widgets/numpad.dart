import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onClearPressed;
  final Function() onGoPressed;

  const Numpad({
    super.key,
    required this.onKeyPressed,
    required this.onClearPressed,
    required this.onGoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.8,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                ],
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                ],
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                ],
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('0'),
                  _buildButton('C', onPressed: onClearPressed),
                  _buildButton('GO', onPressed: onGoPressed),
                ],
              )),
            ],
          ),
        ));
  }

  Widget _buildButton(String text, {Function()? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onPressed != null ? onPressed() : onKeyPressed(text),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
