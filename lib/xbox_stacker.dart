import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';

class _ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, size.height); // Start from bottom left
    path.lineTo(30, 0.0); // Adjust this value to create an ~80° angle
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width - 30, size.height); // Adjust this value to create an ~80° angle

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class XboxImageStacker extends StatelessWidget {
  final List<ImageProvider?> images;

  final bool parallelogramTile;
 

  const XboxImageStacker({super.key, required this.images, this.parallelogramTile = false });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          var sliceWidth = constraints.maxWidth / images.length;
          var trueImages = images.where((x) => x != null).map((e) => e!).toList();
          if (trueImages.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: trueImages.first,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: trueImages.asMap().entries.map((entry) {
                  int idx = entry.key;
                  ImageProvider image = entry.value;
                  return Transform.translate(
                    offset: Offset(sliceWidth * idx, 0),
                    child: parallelogramTile
                        ? CustomPaint(
                            painter: idx == 0 ? null : _ShadowPainter(),
                            child: ClipPath(
                              clipper: _ParallelogramClipper(),
                              child: Container(
                                width: sliceWidth,
                                height: constraints.maxHeight,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: idx == 0 ? Xbox.emptyImage : image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: sliceWidth,
                            height: constraints.maxHeight,
                            decoration: BoxDecoration(
                              boxShadow: [
                                if (idx > 0)
                                  BoxShadow(
                                    color: Xbox.SlateGray.withOpacity(0.8), //color of shadow
                                    spreadRadius: 5, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: const Offset(0, 2), // changes position of shadow
                                  ),
                              ],
                              image: DecorationImage(
                                image: idx == 0 ? Xbox.emptyImage : image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  );
                }).toList(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}

class _ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0.0, size.height); // Start from bottom left
    path.lineTo(30, 0.0); // Adjust this value to create an ~80° angle
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width - 40, size.height); // Adjust this value to create an ~80° angle
    path.close();

    final paint = Paint()
      ..color = Xbox.SlateGray // Shadow color
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 50); // Increase sigma for larger shadow

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
