import 'package:flutter/material.dart';

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Menu", style: TextStyle(fontSize: 24)),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.star),
                label: const Text("The best", style: TextStyle(fontSize: 24)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.star),
                label: const Text("The best", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
