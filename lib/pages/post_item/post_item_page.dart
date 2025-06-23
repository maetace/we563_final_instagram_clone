// lib/pages/post_item/post_item_page.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/pages/post_item/post_item_controller.dart';
import '/pages/home/home_controller.dart';
import '/models/comment_item_model.dart';
import '/utils.dart';

class PostItemPage extends GetView<PostItemController> {
  const PostItemPage({super.key});

  static const title = 'Post';
  static const route = '/post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            CircleAvatar(radius: 16, foregroundImage: AssetImage(controller.postItem.ownerImage)),
            const SizedBox(width: 8),
            Text(controller.postItem.ownerName, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})],
        actionsPadding: const EdgeInsets.only(right: 8),
      ),
      body: Obx(() {
        if (controller.commentItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: controller.commentItems.length + 1,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildPostHeader(context);
            }

            final comment = controller.commentItems[index - 1];
            return _buildCommentItem(context, comment);
          },
        );
      }),
      bottomNavigationBar: SafeArea(child: _buildCommentBox(context)),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    int currentPage = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === Carousel ===
            CarouselSlider.builder(
              itemCount: controller.postItem.images.length,
              itemBuilder: (context, index, realIndex) {
                final image = controller.postItem.images[index];
                return isWebPath(image)
                    ? Image.network(image, width: Get.width, fit: BoxFit.cover)
                    : Image.asset(image, width: Get.width, fit: BoxFit.cover);
              },
              options: CarouselOptions(
                height: 380,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),

            // === Indicator ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  controller.postItem.images.asMap().entries.map((entry) {
                    final isSelected = entry.key == currentPage;
                    final color = Theme.of(context).colorScheme.primary;

                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? color : color.withValues(alpha: 0xDD),
                      ),
                    );
                  }).toList(),
            ),

            // === Actions ===
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      controller.postItem.isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 28,
                      color: controller.postItem.isLiked ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        controller.postItem.isLiked = !controller.postItem.isLiked;
                        controller.postItem.likes += controller.postItem.isLiked ? 1 : -1;
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('${controller.postItem.likes}'),

                  const SizedBox(width: 16),
                  Icon(Icons.mode_comment_outlined, size: 28),
                  const SizedBox(width: 4),
                  Text('${controller.postItem.comments}'),

                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/icons/send_message_icon.svg',
                    height: 28,
                    width: 28,
                    colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                  ),

                  const Spacer(),

                  Icon(Icons.bookmark_border, size: 28),
                ],
              ),
            ),

            // === Caption ===
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(text: controller.postItem.ownerName, style: Theme.of(context).textTheme.titleSmall),
                    const TextSpan(text: '  '),
                    TextSpan(text: controller.postItem.description),
                  ],
                ),
              ),
            ),

            // === Created date ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                timeAgo(controller.postItem.createdDate),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget _buildCommentItem(BuildContext context, CommentItem comment) {
    return ListTile(
      leading: CircleAvatar(radius: 18, foregroundImage: AssetImage(comment.ownerImage)),
      title: Text(comment.ownerName, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(comment.message),
    );
  }

  Widget _buildCommentBox(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final currentUser = homeController.userRxn.value;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.commentTextEditingController,
              decoration: InputDecoration(
                hintText:
                    currentUser != null ? 'comment_as'.trParams({'user': currentUser.username}) : 'write_a_comment'.tr,
              ),
              onChanged: controller.onCommentTextChanged,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.send),
              onPressed: controller.canComment ? controller.createComment : null,
            ),
          ),
        ],
      ),
    );
  }
}
