import 'package:flutter/material.dart';

import '../widgets/option_tile.dart';
import 'placeholder_screen.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student')),
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
              icon: Icons.school,
              label: 'Learn',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PlaceholderScreen(
                    title: 'Learn',
                    icon: Icons.school,
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
