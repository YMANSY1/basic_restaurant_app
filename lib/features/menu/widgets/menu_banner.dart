import 'package:flutter/material.dart';

import 'custom_searchbar.dart';

class MenuBanner extends StatelessWidget {
  const MenuBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0x6fffd700),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(height: 12),
            const Text(
              'Enjoy Authentic Middle Eastern Dishes at the Click of a Button',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Have a browse through our menu!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomSearchBar(),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
