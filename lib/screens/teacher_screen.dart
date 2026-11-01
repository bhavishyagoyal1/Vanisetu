import 'package:flutter/material.dart';

import '../widgets/option_tile.dart';
import 'placeholder_screen.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            OptionTile(
              icon: Icons.translate,
              label: 'Translate',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PlaceholderScreen(
                    title: 'Translate',
                    icon: Icons.translate,
                  ),
                ),
              ),
            ),
            OptionTile(
              icon: Icons.auto_stories,
              label: 'Curriculum',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PlaceholderScreen(
                    title: 'Curriculum',
                    icon: Icons.auto_stories,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
