import 'package:flutter/material.dart';
import 'package:klizards/utilities/helper_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => getInitialRootWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // FadeTransition(
            // opacity: _fadeAnimation,
             Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ghm.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
