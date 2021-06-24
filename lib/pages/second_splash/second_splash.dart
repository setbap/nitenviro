// import 'package:flutter/material.dart';
//
// class SecondSplash extends StatefulWidget {
//   final Widget page;
//   final Future<bool> Function() goNextFn;
//   const SecondSplash({
//     Key? key,
//     required this.page,
//     required this.goNextFn,
//   }) : super(key: key);
//
//   @override
//   _SecondSplashState createState() => _SecondSplashState();
// }
//
// class _SecondSplashState extends State<SecondSplash> {
//   bool? goNext = false;
//   @override
//   void initState() {
//     super.initState();
//     startedFn();
//   }
//
//   startedFn() async {
//     final isGoing = await widget.goNextFn();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: goNext
//           ? widget.page
//           : Center(
//               child: Image.asset("./assets/icon.png"),
//             ),
//     );
//   }
// }
