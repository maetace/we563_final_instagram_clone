// lib/pages/home/widgets/post_item_widget.dart

// ===============================
// WIDGET: POST ITEM
// ===============================

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/models/post_item_model.dart';
import '/pages/post_item/post_item_page.dart';
import '/utils.dart';

// ===============================
// POST ITEM WIDGET
// ===============================

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({super.key, required this.item});

  final PostItem item;

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  int _currentPage = 0;
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.item.isLiked;
    likeCount = widget.item.likes;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
      widget.item.isLiked = isLiked;
      widget.item.likes = likeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(PostItemPage.route, arguments: {'postItem': widget.item});
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===============================
            // HEADER
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(radius: 18, foregroundImage: AssetImage(widget.item.ownerImage)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(widget.item.ownerName, style: Theme.of(context).textTheme.titleSmall)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
            ),

            // ===============================
            // CAROUSEL
            // ===============================
            CarouselSlider.builder(
              itemCount: widget.item.images.length,
              itemBuilder: (context, index, realIndex) {
                final image = widget.item.images[index];
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
                    _currentPage = index;
                  });
                },
              ),
            ),

            // ===============================
            // INDICATOR DOTS
            // ===============================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  widget.item.images.asMap().entries.map((entry) {
                    final isSelected = entry.key == _currentPage;
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

            // ===============================
            // ACTIONS
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 28,
                      color: isLiked ? Colors.red : null,
                    ),
                    onPressed: toggleLike,
                  ),
                  const SizedBox(width: 4),
                  Text('$likeCount'),

                  const SizedBox(width: 16),
                  Icon(Icons.mode_comment_outlined, size: 28),
                  const SizedBox(width: 4),
                  Text('${widget.item.comments}'),

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

            // ===============================
            // CAPTION
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(text: widget.item.ownerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: '  '),
                    TextSpan(text: widget.item.description),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ===============================
            // CREATED DATE
            // ===============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                timeAgo(widget.item.createdDate),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
