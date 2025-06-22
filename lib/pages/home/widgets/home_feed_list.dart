// lib/pages/home/widgets/home_feed_list.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/home/home_controller.dart';
import '/pages/home/widgets/post_item_widget.dart';
import '/pages/home/widgets/post_item_placeholder_widget.dart';

class HomeFeedList extends GetView<HomeController> {
  const HomeFeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
      child: Obx(() {
        if (controller.postItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.onRefreshPosts,
          child: ListView.separated(
            controller: controller.scrollController,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: controller.postItems.length,
            itemBuilder: (context, index) {
              final item = controller.postItems[index];

              if (item == null) {
                return const PostItemPlaceholderWidget();
              } else {
                return PostItemWidget(item: item);
              }
            },
          ),
        );
      }),
    );
  }
}
