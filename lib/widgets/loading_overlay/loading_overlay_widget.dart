import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loading_overlay_controller.dart';

class LoadingOverlayWidget extends GetView<LoadingOverlayController> {
  const LoadingOverlayWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return Stack(
          children: [
            child,
            AnimatedOpacity(
              opacity: 0.5,
              duration: Duration(milliseconds: 1500),
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        );
      }
      return child;
    });
  }
}
