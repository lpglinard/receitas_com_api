import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us!"),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            const Text(
              "Write us a message."
            )
          ],
        ),
      )
    );
  }
}
