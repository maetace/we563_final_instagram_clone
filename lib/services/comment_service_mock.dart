// lib/services/comment_service_mock.dart

// ===============================
// MOCK SERVICE: COMMENT
// ===============================

import 'package:get/get.dart';
import '/utils.dart';
import '../models/comment_item_model.dart';
import '../data/comment_data_mock.dart';
import '../data/post_data_mock.dart';
import '/services/comment_service.dart';
import '/services/account_service_mock.dart'; // ⭐️ mock ใช้ currentUser

// ===============================
// COMMENT SERVICE (MOCK)
// ===============================

/// CommentServiceMock
/// - Implements CommentService
/// - Provides mock comment list and create comment
/// - Uses Get.find\<AccountServiceMock>() to get current user
class CommentServiceMock extends GetxService implements CommentService {
  late List<CommentItem> _items;

  // ===============================
  // INIT (LOAD MOCK COMMENTS)
  // ===============================

  @override
  void onInit() {
    _items = List<CommentItem>.from(mockComments);
    super.onInit();
  }

  // ===============================
  // GET COMMENTS (PAGED)
  // ===============================

  @override
  Future<List<CommentItem>> getComments(String postId, {int pageIndex = 1, int pageSize = 3}) async {
    await 2.delay();

    final filtered = _items.where((c) => c.postId == postId).toList();

    var items = <CommentItem>[];
    var index = (pageIndex - 1) * pageSize;

    while (index < filtered.length) {
      items.add(filtered[index]);
      if (items.length == pageSize) {
        break;
      }
      index++;
    }

    return items;
  }

  // ===============================
  // CREATE COMMENT ITEM
  // ===============================

  @override
  Future<CommentItem> createCommentItem({required String postId, required String message}) async {
    await 2.delay();

    final currentUser = Get.find<AccountServiceMock>().currentUser!;

    var item = CommentItem(
      id: 'comment.${randomString(30)}',
      postId: postId,
      ownerName: currentUser.username,
      ownerImage: currentUser.avatar,
      message: message,
      createdDate: DateTime.now(),
    );

    _items.insert(0, item);

    // update post.comments++
    final post = mockPosts.firstWhereOrNull((p) => p.id == postId);
    if (post != null) {
      post.comments += 1; // ⭐️ make sure post.comments is not final!
    }

    return item;
  }
}
