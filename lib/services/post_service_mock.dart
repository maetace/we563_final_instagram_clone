// lib/services/post_service_mock.dart

// ===============================
// MOCK SERVICE: POST
// ===============================

import 'package:get/get.dart';
import '/utils.dart';
import '/models/post_item_model.dart';
import '/data/post_data_mock.dart';
import 'post_service.dart';
import '/services/account_service_mock.dart'; // ⭐️ ใช้ currentUser

// ===============================
// POST SERVICE (MOCK)
// ===============================

/// PostServiceMock
/// - Implements PostService
/// - Provides mock post list and create post
/// - Uses RxList for reactive update
/// - Uses Get.find\<AccountServiceMock>() to get current user
class PostServiceMock extends GetxService implements PostService {
  late RxList<PostItem> _items;

  // ===============================
  // INIT (LOAD MOCK POSTS)
  // ===============================

  @override
  void onInit() {
    _items = RxList<PostItem>.from(mockPosts);
    super.onInit();
  }

  // ===============================
  // GET POST ITEMS (PAGED)
  // ===============================

  @override
  Future<List<PostItem>> getPostItems({int pageIndex = 1, int pageSize = 3}) async {
    await 3.delay();

    var items = <PostItem>[];
    var index = (pageIndex - 1) * pageSize;

    while (index < _items.length) {
      items.add(_items[index]);
      if (items.length == pageSize) {
        break;
      }
      index++;
    }

    return items;
  }

  // ===============================
  // CREATE POST ITEM
  // ===============================

  @override
  Future<PostItem> createPostItem({required String description, required List<String> images}) async {
    await 3.delay();

    final currentUser = Get.find<AccountServiceMock>().currentUser!;

    var item = PostItem(
      id: 'post.${randomString(30)}',
      ownerName: currentUser.username,
      ownerImage: currentUser.avatar,
      images: images,
      likes: 0,
      comments: 0,
      isLiked: false,
      description: description,
      createdDate: DateTime.now(),
    );

    _items.insert(0, item);
    _items.refresh();

    return item;
  }
}
