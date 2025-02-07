import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  const HomeShimmer({super.key, required this.inAsyncCall, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Visibility(
      replacement: child,
      visible: inAsyncCall,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Stack(
              children: [
                Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 215, 217, 220),
                      const Color.fromARGB(255, 217, 219, 224).withOpacity(0.2),
                      const Color.fromARGB(255, 208, 211, 214).withOpacity(0.4),
                      const Color.fromARGB(255, 214, 219, 222).withOpacity(1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  child: CustomWidget.rectangular(radius: 8, width: size.width, height: size.width / 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  const CustomWidget.rectangular({super.key, this.width = double.infinity, required this.height, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: Colors.grey[400]!),
    );
  }
}
