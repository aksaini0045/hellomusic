import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicapp/screens/splashscreen.dart';

import './provider/provider.dart';
import './screens/homescreen.dart';

void main() {
  runApp(Sainimusic());
}

class Sainimusic extends StatelessWidget {
  // const Sainimusic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Songprovider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme(
              primaryVariant: Color.fromARGB(255, 25, 75, 241),
              secondaryVariant: Color.fromARGB(255, 151, 133, 228) ,
                onPrimary: Colors.white,
                onError: Colors.white,
                onSecondary: Color.fromARGB(255, 253, 251, 251),
                onSurface: Colors.black,
                onBackground: Colors.black,
                brightness: Brightness.light,
                surface: Colors.pink.shade200,
                error: Colors.red,
                background: Colors.white,
                primary: Color.fromARGB(255, 25, 75, 241),
                secondary: Color.fromARGB(255, 151, 133, 228))),
        home: Scaffold(body: MainScreenbuilder()),
      ),
    );
  }
}

class MainScreenbuilder extends StatelessWidget {
  // const MainScreenbuilder({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<Songprovider>(context, listen: false).initialloading(),
        builder: (context, snapshot) {
          print('oading');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: SplashScreen(),
            );
          }
          return Homescreen();
        });
  }
}
