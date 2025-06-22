// lib/pages/home/widgets/post_item_placeholder_widget.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostItemPlaceholderWidget extends StatelessWidget {
  const PostItemPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surfaceContainerHigh;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === Header: owner image + name ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: baseColor),
                  const SizedBox(width: 8),
                  Container(height: 14, width: 120, color: baseColor),
                  const Spacer(),
                  Container(height: 24, width: 24, color: baseColor),
                ],
              ),
            ),

            // === Carousel ===
            Container(height: 380, color: baseColor),

            // === Indicator (dots) ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: baseColor),
                ),
              ),
            ),

            // === Actions (like, comment, send, bookmark) ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Container(height: 28, width: 28, color: baseColor),
                  const SizedBox(width: 16),
                  Container(height: 28, width: 28, color: baseColor),
                  const SizedBox(width: 16),
                  Container(height: 28, width: 28, color: baseColor),
                  const Spacer(),
                  Container(height: 28, width: 28, color: baseColor),
                ],
              ),
            ),

            // === Likes ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(height: 14, width: 80, color: baseColor),
            ),
            const SizedBox(height: 8),

            // === Caption ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(height: 14, width: double.infinity, color: baseColor),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(height: 14, width: 120, color: baseColor),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
