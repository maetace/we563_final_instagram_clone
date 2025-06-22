// lib/services/post_service_mock.dart

import 'dart:math';
import 'package:get/get.dart';
import '/utils.dart';
import '/models/post_item_model.dart';
import 'post_service.dart';
import '/services/account_service_mock.dart'; // ⭐️ ใช้ currentUser

class PostServiceMock extends GetxService implements PostService {
  late RxList<PostItem> _items;

  List<PostItem> get items => _items; // ✅ public getter

  @override
  void onInit() {
    _items = RxList<PostItem>.generate(20, (_) => _randomPostItem());
    super.onInit();
  }

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

  @override
  Future<PostItem> createPostItem({required String description, required List<String> images}) async {
    await 3.delay();

    final currentUser = Get.find<AccountServiceMock>().currentUser!;

    final newPost = PostItem(
      id: 'post.${randomString(20)}',
      ownerName: currentUser.username,
      ownerImage: currentUser.avatar,
      images: images.isNotEmpty ? images : _randomPostImages(currentUser.username),
      likes: 0,
      comments: 0,
      isLiked: false,
      description: description,
      createdDate: DateTime.now(),
    );

    _items.insert(0, newPost);
    _items.value = List.of(_items); // ✅ refresh แบบปลอดภัย

    return newPost;
  }

  // === MOCK POST GENERATOR ===

  final List<Map<String, String>> _mockUsers = [
    {'username': 'yelena', 'avatar': 'assets/avatars_mock/yelena.jpg'},
    {'username': 'usagent', 'avatar': 'assets/avatars_mock/usagent.jpg'},
    {'username': 'valentina', 'avatar': 'assets/avatars_mock/valentina.jpg'},
    {'username': 'redguardian', 'avatar': 'assets/avatars_mock/redguardian.jpg'},
    {'username': 'taskmaster', 'avatar': 'assets/avatars_mock/taskmaster.jpg'},
    {'username': 'justbob', 'avatar': 'assets/avatars_mock/justbob.jpg'},
    {'username': 'ghost', 'avatar': 'assets/avatars_mock/ghost.jpg'},
    {'username': 'buckybarnes', 'avatar': 'assets/avatars_mock/buckybarnes.jpg'},
    {'username': 'baronzemo', 'avatar': 'assets/avatars_mock/baronzemo.jpg'},
  ];

  List<String> _randomPostImages(String username) {
    final r = Random();

    final cleanName = username.toLowerCase();

    final files = [
      'assets/posts_mock/${cleanName}001.webp',
      'assets/posts_mock/${cleanName}002.webp',
      'assets/posts_mock/${cleanName}003.webp',
    ];

    final count = r.nextInt(3) + 1;
    files.shuffle();

    return files.take(count).toList();
  }

  PostItem _randomPostItem() {
    final r = Random();

    final user = _mockUsers[r.nextInt(_mockUsers.length)];
    final username = user['username']!;
    final avatar = user['avatar']!;

    final images = _randomPostImages(username);

    return PostItem(
      id: 'post.${randomString(20)}',
      ownerName: username,
      ownerImage: avatar,
      images: images,
      likes: r.nextInt(100),
      comments: r.nextInt(20),
      isLiked: r.nextBool(),
      description: 'Random post from @$username',
      createdDate: DateTime.now().subtract(Duration(minutes: r.nextInt(5000))),
    );
  }
}
