import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          child: const Text("data"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
