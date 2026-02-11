import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationBottomSheet extends StatelessWidget {
  const InformationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final infoList = [
      {
        "title": "Trang web chính thức (Giới thiệu, Đăng ký thi, Hỏi đáp,...)",
        "url": "https://aptistests.vn/",
      },
      {
        "title": "Trang web mô phỏng bài thi",
        "url": "https://aptisweb.com/aptis-exam-library/aptis-general",
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: infoList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = infoList[index];

                return InkWell(
                  onTap: () {
                    openWeb(item['url']);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['title'] ?? '',
                            style: AppTextStyle.largeBlackBold.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.open_in_new_rounded,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openWeb(String? url) async {
  if (url == null) return;
  final uri = Uri.parse(url);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication, 
  )) {
    throw 'Không thể mở $url';
  }
}