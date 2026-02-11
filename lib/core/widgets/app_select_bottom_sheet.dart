import 'package:flutter/material.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';

class AppSelectorItem {
  final String title;
  final bool isSelected;

  AppSelectorItem({required this.title, this.isSelected = false});
}

class AppSelectorBottomSheet extends StatelessWidget {
  const AppSelectorBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    this.heightFactor = 0.8,
  });

  final String title;
  final List<AppSelectorItem> items;
  final ValueChanged<int> onItemSelected;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(title, style: AppTextStyle.xxLargeBlackBold),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.pop(context);
                        onItemSelected(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: item.isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: item.isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: item.isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            if (item.isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
