import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO
// styling widget
// call firebase auth API
class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.red[400],
        ),
        onPressed: () {},
        child: Row(
          children: const [
            SizedBox(
                width: 60, child: Center(child: Icon(FontAwesomeIcons.google))),
            VerticalDivider(
              color: Colors.white,
              width: 1,
              endIndent: 7,
              indent: 7,
            ),
            Spacer(),
            Text(
              "Sign In with Google",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
