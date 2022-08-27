// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class Splash extends StatefulWidget {
//   @override
//   _SplashState createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   bool _initialized = false;
//   AppState appState;
//
//   @override
//   Widget build(BuildContext context) {
//     appState = Provider.of<AppState>(context);
//     final query = MediaQuery.of(context);
//     final size = query.size;
//     final itemWidth = size.width;
//     final itemHeight = itemWidth * (size.width / size.height);
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             child: Image.asset('assets/icons/icon.png',
//                 width: itemWidth, height: itemHeight),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_initialized) {
//       _initialized = true;
//       Timer(const Duration(milliseconds: 2000), () {
//         appState.setSplashFinished();
//       });
//     }
//   }
// }
