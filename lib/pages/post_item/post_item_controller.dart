// lib/pages/post_item/post_item_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/comment_item_model.dart';
import '/models/post_item_model.dart';
import '/services/comment_service.dart';
import '/services/account_service.dart';
import '/services/account_service_mock.dart'; // ⭐️ ใช้ currentUser

class PostItemController extends GetxController {
  PostItemController({required PostItem postItem}) {
    _postItem = postItem;
  }

  late final PostItem _postItem;
  PostItem get postItem => _postItem;

  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;

  // late final AccountServiceMock _account;
  late final AccountService _account;
  late final CommentService _commentService;

  final _commentItems = <CommentItem>[].obs;
  List<CommentItem> get commentItems => _commentItems;

  final _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;
  final _pageSize = 5;
  var _hasMoreItems = false;
  final _loading = false.obs;
  bool get loading => _loading.value;

  final scrollController = ScrollController();

  final _canComment = false.obs;
  bool get canComment => _canComment.value;
  final commentTextEditingController = TextEditingController();

  var _isCommentCreating = false;

  @override
  void onInit() {
    // _account = Get.find<AccountServiceMock>();
    _account = Get.find<AccountService>();
    _commentService = Get.find<CommentService>();

    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onReady() {
    _loadCommentItems();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    commentTextEditingController.dispose();
    super.onClose();
  }

  // === Carousel ===
  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  // === Load comments ===
  Future<void> _loadCommentItems() async {
    if (_loading.value) return;

    _loading.value = true;
    try {
      if (_pageIndex.value == 1) {
        _commentItems.clear();
      }

      final newItems = await _commentService.getComments(
        _postItem.id,
        pageIndex: _pageIndex.value,
        pageSize: _pageSize,
      );

      if (newItems.isNotEmpty) {
        _commentItems.addAll(newItems);
      }

      _hasMoreItems = newItems.length >= _pageSize;
    } finally {
      _loading.value = false;
    }
  }

  void _onScroll() {
    final isAtBottom = scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100;

    if (isAtBottom && _hasMoreItems && !_loading.value) {
      _pageIndex.value++;
      _loadCommentItems();
    }
  }

  // === Comment box ===
  void onCommentTextChanged(String text) {
    _validateComment();
  }

  void _validateComment() {
    _canComment.value = commentTextEditingController.text.trim().isNotEmpty && !_isCommentCreating;
  }

  Future<void> createComment() async {
    final text = commentTextEditingController.text.trim();
    if (text.isEmpty || _isCommentCreating) return;

    // Scroll to top
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

    commentTextEditingController.clear();
    _isCommentCreating = true;
    _validateComment();

    try {
      // final currentUser = _account.currentUser!;
      final currentUser = (_account as AccountServiceMock).currentUser!;

      final newComment = CommentItem(
        id: 'comment.${DateTime.now().millisecondsSinceEpoch}',
        postId: _postItem.id,
        ownerName: currentUser.username,
        ownerImage: currentUser.avatar,
        message: text,
        createdDate: DateTime.now(),
      );

      // Insert new comment at top
      _commentItems.insert(0, newComment);

      // ✅ เพิ่มเลข local
      _postItem.comments++;
      update(); // ถ้ามี widget ใช้ GetBuilder() จะ trigger
    } finally {
      _isCommentCreating = false;
      _validateComment();
    }
  }
}
