// lib/pages/home/home_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/models/account_model.dart';
import '/services/account_service.dart';
import '/models/post_item_model.dart';
import '/services/post_service.dart';

class HomeController extends GetxController {
  final Logger _logger = Logger();

  // Scaffold
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Tab index
  final _currentTabIndex = 0.obs;
  int get currentTabIndex => _currentTabIndex.value;

  void onBottomNavigationBarItemTap(int index) {
    _currentTabIndex.value = index;
  }

  // UserRx
  final userRxn = Rxn<CurrentAccount>();

  // Services
  late AccountService _account;
  late PostService _postService;

  // Feed (PostItems)
  final postItems = <PostItem?>[].obs;
  final scrollController = ScrollController();

  // Paging
  var pageIndex = 1;
  final pageSize = 3;
  final isLoading = false.obs;
  final hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find<AccountService>();
    _postService = Get.find<PostService>();
    loadCurrentAccount();
    loadInitialPosts();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Load current user
  Future<void> loadCurrentAccount() async {
    final account = await _account.getCurrentAccount();
    if (account != null) {
      userRxn.value = account;
      _logger.i('🏠 Account loaded: ${account.fullname}');
    } else {
      _logger.w('🏠 No account in session. Redirect to login');
      Get.offAllNamed('/login');
    }
  }

  // Load posts (initial)
  Future<void> loadInitialPosts() async {
    pageIndex = 1;
    postItems.clear();
    await _loadPosts();
  }

  // Load more posts
  Future<void> loadMorePosts() async {
    if (isLoading.value || !hasMore.value) return;
    pageIndex++;
    await _loadPosts();
  }

  // Core load
  Future<void> _loadPosts() async {
    isLoading.value = true;
    try {
      // Append placeholder
      postItems.addAll(List.generate(pageSize, (_) => null));

      final newItems = await _postService.getPostItems(pageIndex: pageIndex, pageSize: pageSize);

      // Remove placeholder
      postItems.removeWhere((item) => item == null);

      if (newItems.isEmpty) {
        hasMore.value = false;
      } else {
        postItems.addAll(newItems);
      }
    } catch (e) {
      _logger.e('Error loading posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh
  Future<void> onRefreshPosts() async {
    await loadInitialPosts();
  }

  // Scroll detect
  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMorePosts();
    }
  }

  // Logout
  bool get isLogOutLoading => _isLogOutLoading.value;
  final _isLogOutLoading = false.obs;

  void onLogOutPressed() {
    if (Get.isBottomSheetOpen ?? false) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(32),
        color: Colors.white,
        child: Wrap(
          children: [
            Center(
              child: Text(
                'Are you sure you want to log out?',
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 32),
            ListTile(leading: const Icon(Icons.close), title: const Text('No'), onTap: () => Get.back()),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Yes'),
              onTap: () async {
                Get.back();
                _isLogOutLoading.value = true;
                await _account.logOut();
                _logger.i('🔓 Logged out successfully');
                _isLogOutLoading.value = false;
                Get.snackbar('Logged out', 'See you again soon!');
                Get.offAllNamed('/welcome');
              },
            ),
          ],
        ),
      ),
    );
  }

  void onWelcomePressed() {
    Get.offAllNamed('/welcome');
  }
}
