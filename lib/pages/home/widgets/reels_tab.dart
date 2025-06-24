// lib/pages/home/widgets/reels_tab.dart

// ===============================
// WIDGET: REELS TAB
// ===============================

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ===============================
// REELS TAB
// ===============================

class ReelsTab extends StatefulWidget {
  final int currentTabIndex;
  const ReelsTab({super.key, required this.currentTabIndex});

  @override
  State<ReelsTab> createState() => _ReelsTabState();
}

class _ReelsTabState extends State<ReelsTab> {
  final List<Map<String, String>> _videos = [
    {
      'id': 'RIu5CJHrDe8',
      'user': 'buckybarnes',
      'avatar': 'assets/avatars_mock/buckybarnes.jpg',
      'caption': 'Awesome shot!',
    },
    {
      'id': 'BO9yzFFfxVg',
      'user': 'usagent',
      'avatar': 'assets/avatars_mock/usagent.jpg',
      'caption': 'US Agent in action',
    },
    {
      'id': 'KRZxpVtzFF0',
      'user': 'valentina',
      'avatar': 'assets/avatars_mock/valentina.jpg',
      'caption': 'Secret vibes',
    },
    {'id': 'sMVIBr-7hgE', 'user': 'yelena', 'avatar': 'assets/avatars_mock/yelena.jpg', 'caption': 'Training time'},
    {
      'id': 'wF3Jqk-wODo',
      'user': 'redguardian',
      'avatar': 'assets/avatars_mock/redguardian.jpg',
      'caption': 'Feeling strong!',
    },
  ];

  late PageController _pageController;
  late YoutubePlayerController _ytController;
  int _currentIndex = 0;
  bool isLiked = false;
  int likeCount = 123;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadVideo(_videos[_currentIndex]['id']!);
  }

  void _loadVideo(String videoId) {
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(mute: false, showControls: false, showFullscreenButton: false, loop: true),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _ytController.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ReelsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTabIndex == 2 && widget.currentTabIndex != 2) {
      _ytController.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.black,

        // ===============================
        // APP BAR
        // ===============================
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Reels',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_upward, size: 28, color: Colors.white),
                    onPressed: () {
                      if (_currentIndex > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward, size: 28, color: Colors.white),
                    onPressed: () {
                      if (_currentIndex < _videos.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, size: 28, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),

        // ===============================
        // PAGE VIEW
        // ===============================
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _videos.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              isLiked = false;
              likeCount = 123;
              _ytController.close();
              _loadVideo(_videos[index]['id']!);
            });
          },
          itemBuilder: (context, index) {
            final video = _videos[index];
            return Stack(
              children: [
                // YOUTUBE PLAYER
                Positioned.fill(child: YoutubePlayer(controller: _ytController, aspectRatio: 9 / 16)),

                // SWIPE OVERLAY
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      if (details.primaryDelta! < -20 && _currentIndex < _videos.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      } else if (details.primaryDelta! > 20 && _currentIndex > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    onDoubleTap: () {
                      setState(() {
                        isLiked = !isLiked;
                        likeCount += isLiked ? 1 : -1;
                      });
                    },
                  ),
                ),

                // RIGHT ACTIONS
                Positioned(
                  right: 16,
                  bottom: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 28,
                          color: isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            likeCount += isLiked ? 1 : -1;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('$likeCount', style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 24),
                      const Icon(Icons.mode_comment_outlined, size: 28, color: Colors.white),
                      const SizedBox(height: 8),
                      const Text('56', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 24),
                      const Icon(Icons.send, size: 28, color: Colors.white),
                      const SizedBox(height: 8),
                      const Text('12', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                // BOTTOM USER + CAPTION
                Positioned(
                  left: 16,
                  bottom: 32,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 18, backgroundImage: AssetImage(video['avatar']!)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${video['user']}',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(video['caption']!, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
