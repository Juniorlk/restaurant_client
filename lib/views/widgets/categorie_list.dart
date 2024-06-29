import 'package:flutter/material.dart';

import '../../models/categorie_model.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;

  const CategoryGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _calculateGridViewHeight(categories.length),
      child: Visibility(
        visible: categories.isNotEmpty,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 3,
            mainAxisExtent: 70.0, // Adjust as needed
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Center(
                child: Column(
                  children: [
                    Image.network(
                      "https://cdn.pixabay.com/photo/2017/03/23/19/57/asparagus-2169305_1280.jpg",
                      width: 60,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      category.name,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double _calculateGridViewHeight(int categoryCount) {
    int rows = (categoryCount / 4).ceil();
    return rows * (70.0 + 4.0) - 4.0;
  }
}
