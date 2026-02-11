import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AnswersPage extends StatelessWidget {
  const AnswersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqList = [
      {
        "question": "Khi đi thi có được phát nháp và bút không?",
        "answer":
            "-Có 1 bút chì và 1 tờ nháp (in sẵn thông tin thí sinh).\n-Chỉ có 1 tờ nháp duy nhất, dùng tiết kiệm.\n-Nháp đúng kỹ năng đang thi (viết Speaking mà nháp Writing là phạm quy)",
      },
      {
        "question": "Trong quá trình làm bài có được đi vệ sinh không?",
        "answer": "Không được đi trước khi thi xong Speaking và Listening.",
      },
      {
        "question": "Có tủ gửi đồ cho thí sinh không?",
        "answer":
            "-Có locker gửi đồ tại điểm thi.\n-Không được mang vào phòng thi: điện thoại, đồ cá nhân, mọi loại đồng hồ.",
      },
      {
        "question": "Có được quay lại câu hỏi trước để kiểm tra không?",
        "answer": "Có, với tất cả kỹ năng trừ Speaking.",
      },
      {
        "question": "Bao lâu thì có kết quả?",
        "answer":
            "-3-5 ngày: nhận mail tra cứu kết quả online.\n-10 ngày làm việc: nhận chứng chỉ Aptis ESOL (nhận trực tiếp hoặc chuyển phát).",
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BlocBuilder<NotificationBloc, NotificationState>(
              //   builder: (context, state) {
              //     final body = state.latestBody;
              //     return body == null
              //         ? const SizedBox()
              //         : Container(
              //             width: double.infinity,
              //             padding: const EdgeInsets.all(16),
              //             decoration: BoxDecoration(
              //               color: Colors.yellow.shade100,
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(color: Colors.amber, width: 1),
              //             ),
              //             child: Text(
              //               "📢 Thông báo: $body",
              //               style: const TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black87,
              //               ),
              //             ),
              //           );
              //   },
              // ),
              // const SizedBox(height: 24),
              const Text(
                "Câu hỏi thường gặp",
                style: AppTextStyle.xxLargeBlackBold,
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = faqList[index];

                  return Container(
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
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item["question"]!,
                          style: AppTextStyle.largeBlackBold.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item["answer"]!,
                            style: AppTextStyle.mediumBlack.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
