import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome back! 🎉', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onWelcomePressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    child: const Text('Welcome'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onLogoutPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    child: const Text('Log Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
