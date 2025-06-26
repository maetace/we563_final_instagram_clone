// lib/pages/home/widgets/story_bar_widget.dart

import 'package:flutter/material.dart';

class StoryBarWidget extends StatelessWidget {
  const StoryBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock story list
    final stories = [
      {'label': 'Your story', 'avatar': 'assets/avatars_mock/yelena.jpg'},
      {'label': 'chatgpt', 'avatar': 'assets/avatars_mock/buckybarnes.jpg'},
      {'label': 'meta', 'avatar': 'assets/avatars_mock/valentina.jpg'},
      {'label': 'perplexity', 'avatar': 'assets/avatars_mock/redguardian.jpg'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 124,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final story = stories[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Colors.orange, Colors.pink]),
                  ),
                  child: CircleAvatar(radius: 48, backgroundImage: AssetImage(story['avatar']!)),
                ),
                const SizedBox(height: 6),
                Text(
                  story['label']!,
                  style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
