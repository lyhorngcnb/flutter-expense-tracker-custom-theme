// 1. category_selector.dart
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryItem> categories;
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    Key? key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category.name;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => onCategorySelected(category.name),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? category.color
                          : category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? category.color
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      category.icon,
                      color: isSelected ? Colors.white : category.color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}