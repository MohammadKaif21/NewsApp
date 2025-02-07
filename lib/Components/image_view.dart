import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_application/Components/cache_image.dart';

class ImageView extends StatefulWidget {
  final int imageId;
  final String imageUrl;
  const ImageView({super.key, required this.imageId, required this.imageUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: Platform.isAndroid ? 0 : 64,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CloseButton(
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onDoubleTap: _handleDoubleTap,
        onDoubleTapDown: _handleDoubleTapDown,
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            transformationController: _transformationController,
            child: Hero(
              tag: widget.imageId,
              child: CacheImage(
                fit: BoxFit.contain,
                image: widget.imageUrl,
                height: double.maxFinite,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //HELPER
  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition; // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0); // Fox a 2x zoom
    }
  }
}
