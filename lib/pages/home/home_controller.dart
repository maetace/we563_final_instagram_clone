// lib/pages/home/home_controller.dart

// ===============================
// CONTROLLER: HOME
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/models/account_model.dart';
import '/services/account_service.dart';
import '/models/post_item_model.dart';
import '/services/post_service.dart';

// ===============================
// HOME CONTROLLER
// ===============================

class HomeController extends GetxController {
  final Logger _logger = Logger();

  // ===============================
  // SCAFFOLD
  // ===============================

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ===============================
  // CURRENT TAB INDEX
  // ===============================

  final _currentTabIndex = 0.obs;
  int get currentTabIndex => _currentTabIndex.value;

  void onBottomNavigationBarItemTap(int index) {
    _currentTabIndex.value = index;
  }

  // ===============================
  // USER
  // ===============================

  final userRxn = Rxn<CurrentAccount>();

  // ===============================
  // SERVICES
  // ===============================

  late AccountService _account;
  late PostService _postService;

  // ===============================
  // FEED (POST ITEMS)
  // ===============================

  final postItems = <PostItem?>[].obs;
  final scrollController = ScrollController();

  // ===============================
  // PAGING
  // ===============================

  var pageIndex = 1;
  final pageSize = 3;
  final isLoading = false.obs;
  final hasMore = true.obs;

  // ===============================
  // INIT
  // ===============================

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

  // ===============================
  // LOAD CURRENT USER
  // ===============================

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

  // ===============================
  // LOAD POSTS (INITIAL)
  // ===============================

  Future<void> loadInitialPosts() async {
    pageIndex = 1;
    postItems.clear();
    await _loadPosts();
  }

  // ===============================
  // LOAD MORE POSTS
  // ===============================

  Future<void> loadMorePosts() async {
    if (isLoading.value || !hasMore.value) return;
    pageIndex++;
    await _loadPosts();
  }

  // ===============================
  // CORE LOAD
  // ===============================

  Future<void> _loadPosts() async {
    isLoading.value = true;
    try {
      postItems.addAll(List.generate(pageSize, (_) => null));

      final newItems = await _postService.getPostItems(pageIndex: pageIndex, pageSize: pageSize);

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

  // ===============================
  // REFRESH POSTS
  // ===============================

  Future<void> onRefreshPosts() async {
    await loadInitialPosts();
  }

  // ===============================
  // SCROLL DETECT
  // ===============================

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMorePosts();
    }
  }

  // ===============================
  // LOGOUT
  // ===============================

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
                'logout_confirm'.tr,
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
                Get.snackbar(
                  'logout_success'.tr,
                  'welcome'.tr,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
                Get.offAllNamed('/welcome');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===============================
  // GO TO WELCOME
  // ===============================

  void onWelcomePressed() {
    Get.offAllNamed('/welcome');
  }
}
