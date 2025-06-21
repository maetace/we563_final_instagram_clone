// lib/services/comment_service_mock.dart

import 'package:get/get.dart';
import '/utils.dart';
import '../models/comment_item_model.dart';
import '../data/comment_data_mock.dart';
import 'comment_service.dart';

class CommentServiceMock extends GetxService implements CommentService {
  late List<CommentItem> _items;

  @override
  void onInit() {
    _items = List<CommentItem>.from(mockComments);
    super.onInit();
  }

  @override
  Future<List<CommentItem>> getComments(String postId, {int pageIndex = 1, int pageSize = 3}) async {
    await 3.delay();
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

  @override
  Future<CommentItem> createCommentItem({required String postId, required String message}) async {
    await 3.delay();
    var item = CommentItem(
      id: 'comment.${randomString(30)}',
      postId: postId,
      ownerName: 'demouser',
      ownerImage: 'assets/images/avatar.webp',
      message: message,
      createdDate: DateTime.now(),
    );
    _items.insert(0, item);
    return item;
  }
}
