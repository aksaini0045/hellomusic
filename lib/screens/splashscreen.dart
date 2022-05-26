import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Center(
      child: Column(children: [
        Image.asset(
          'assets/images/music.jpg',
          width: devicesize.width / 1.2,
          height: devicesize.height / 1.5,
        ),
        SizedBox(
          height: devicesize.height / 50,
        ),
        Text('Hello Music\nMusic with One Click',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ))
      ]),
    );
  }
}
