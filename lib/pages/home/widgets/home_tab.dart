// lib/pages/home/widgets/home_tab.dart

// ===============================
// WIDGET: HOME TAB
// ===============================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/routes.dart';
import '/pages/home/home_controller.dart';
import '/pages/home/widgets/post_item_widget.dart';
import '/pages/home/widgets/post_item_placeholder_widget.dart';

// ===============================
// HOME TAB
// ===============================

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===============================
        // APP BAR
        // ===============================
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          titleSpacing: 16,
          title: SvgPicture.asset('assets/images/instagram_logo.svg', height: 38),
          actions: [
            IconButton(icon: const Icon(Icons.favorite_border, size: 28), onPressed: () {}),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/messenger_icon.svg',
                height: 28,
                width: 28,
                colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),

        // ===============================
        // FEED LIST
        // ===============================
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Obx(() {
                if (controller.postItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: controller.onRefreshPosts,
                  child: ListView.separated(
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemCount: controller.postItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.postItems[index];
                      if (item == null) {
                        return const PostItemPlaceholderWidget();
                      } else {
                        return PostItemWidget(
                          item: item,
                          onCommentPressed: () {
                            Get.toNamed(AppRoutes.postItem, arguments: {'postItem': item});
                          },
                        );
                      }
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
