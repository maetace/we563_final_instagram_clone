// lib/pages/home/widgets/post_item_widget.dart

// ===============================
// WIDGET: POST ITEM
// ===============================

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/models/post_item_model.dart';
import '/utils.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({super.key, required this.item, this.onCommentPressed});

  /// ข้อมูลโพสต์ (จาก mock service หรือ backend)
  final PostItem item;

  /// callback สำหรับเมื่อผู้ใช้กดปุ่ม Comment หรือกดที่รูปภาพ
  final VoidCallback? onCommentPressed;

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  /// เก็บสถานะหน้า carousel ปัจจุบัน (เพื่อเปลี่ยน indicator)
  int _currentPage = 0;

  /// เก็บสถานะถูกใจ (ใช้สำหรับ toggle like)
  late bool isLiked;

  /// จำนวน likes ของโพสต์นี้
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.item.isLiked;
    likeCount = widget.item.likes;
  }

  /// ฟังก์ชัน toggle like เมื่อผู้ใช้กดหัวใจ
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
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ===============================
          // SECTION: HEADER (ชื่อผู้ใช้ + เมนู)
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
          // SECTION: รูปภาพแบบ Carousel
          // กดที่รูปภาพ = เปิดหน้า comment
          // ===============================
          CarouselSlider.builder(
            itemCount: widget.item.images.length,
            itemBuilder: (context, index, realIndex) {
              final image = widget.item.images[index];
              final imageWidget =
                  isWebPath(image)
                      ? Image.network(image, width: Get.width, fit: BoxFit.cover)
                      : Image.asset(image, width: Get.width, fit: BoxFit.cover);

              return GestureDetector(onTap: widget.onCommentPressed, child: imageWidget);
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
          // SECTION: จุด indicator ของ carousel
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
                    decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? color : color.withAlpha(100)),
                  );
                }).toList(),
          ),

          // ===============================
          // SECTION: ปุ่ม Action (like, comment, share, save)
          // ===============================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // ❤️ ปุ่ม like
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

                // 💬 ปุ่ม comment
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.mode_comment_outlined, size: 28), onPressed: widget.onCommentPressed),
                const SizedBox(width: 4),
                Text('${widget.item.comments}'),

                // ✉️ ปุ่ม share (ยังไม่ผูก action)
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/send_message_icon.svg',
                  height: 28,
                  width: 28,
                  colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                ),

                const Spacer(),

                // 📌 ปุ่ม bookmark
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),

          // ===============================
          // SECTION: แคปชันใต้โพสต์
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
          // SECTION: เวลาโพสต์ (เช่น 2 ชั่วโมงที่แล้ว)
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
    );
  }
}
