// lib/pages/explore/widgets/explore_tab.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/home/home_controller.dart';
import '/widgets.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Random();

    // Mock รูปภาพ
    final imagePaths = List.generate(100, (_) {
      final num = (r.nextInt(12) + 1).toString().padLeft(3, '0');
      return 'assets/images/$num.webp';
    });

    return Column(
      children: [
        // APP BAR
        AppBar(
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          titleSpacing: 16,
          title: Text('explore'.tr, style: theme.textTheme.titleLarge),
          actions: const [LanguageSwitcher(), ThemeSwitcher()],
          actionsPadding: const EdgeInsets.only(right: 8),
        ),

        // BODY: Scrollable ส่วนที่เหลือทั้งหมด
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Obx(() {
                final results = controller.filteredUsers;

                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    // ===============================
                    // SEARCH BAR
                    // ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        onChanged: controller.onSearchUserChanged,
                        decoration: InputDecoration(
                          hintText: 'search_hint'.tr,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerHighest,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),

                    // ===============================
                    // USER LIST
                    // ===============================
                    if (results.isNotEmpty) ...[
                      Text('explore_users'.tr, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ...results.map((user) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(foregroundImage: AssetImage(user.avatar)),
                          title: Text(user.username),
                          onTap: () => controller.onBottomNavigationBarItemTap(3),
                        );
                      }),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                    ],

                    // ===============================
                    // IMAGE GRID
                    // ===============================
                    Text('explore_trending'.tr, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: imagePaths.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Image.asset(imagePaths[index], fit: BoxFit.cover);
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
