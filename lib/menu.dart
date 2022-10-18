import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text('jouer'),
        onPressed: () => Navigator.pushNamed(context, '/game'),
      )),
    );
  }
}
