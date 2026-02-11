import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/widgets/app_toast.dart';
import 'package:easyaptis/shared/suggest_bottom_sheet/models/suggest_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuggestBottomSheet extends StatefulWidget {
  const SuggestBottomSheet({
    super.key,
    required this.suggestions,
    this.title = "Suggested answers",
    this.initialShowCopyButtons = false,
  });

  final String title;
  final List<SuggestUiModel> suggestions;
  final bool initialShowCopyButtons;

  @override
  State<SuggestBottomSheet> createState() => _SuggestBottomSheetState();
}

class _SuggestBottomSheetState extends State<SuggestBottomSheet> {
  late bool showCopyButtons;

  @override
  void initState() {
    super.initState();
    showCopyButtons = widget.initialShowCopyButtons;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
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
            Row(
              children: [
                Text(widget.title, style: AppTextStyle.xxLargeBlackBold),
                const Spacer(),
                // IconButton(
                //   icon: Icon(
                //     showCopyButtons
                //         ? Icons.remove_circle_outline_sharp
                //         : Icons.copyright,
                //   ),
                //   visualDensity: VisualDensity.compact,
                //   padding: EdgeInsets.zero,
                //   onPressed: () {
                //     setState(() {
                //       showCopyButtons = !showCopyButtons;
                //     });
                //   },
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.suggestions.length,
                itemBuilder: (context, index) {
                  final q = widget.suggestions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SelectableText(
                                "${q.id}. ${q.title}",
                                style: AppTextStyle.largeBlackBold,
                              ),
                            ),
                            if (showCopyButtons)
                              IconButton(
                                icon: const Icon(Icons.copy, size: 20),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: q.title),
                                  );
                                  AppToast.showSuccess(
                                    context,
                                    message: "Đã sao chép",
                                  );
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SelectableText(
                                  q.suggestion.isNotEmpty
                                      ? q.suggestion
                                      : "No suggestion",
                                  style: AppTextStyle.largeBlack,
                                ),
                              ),
                              if (showCopyButtons && q.suggestion.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.copy, size: 20),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: q.suggestion),
                                    );
                                    AppToast.showSuccess(
                                      context,
                                      message: "Đã sao chép",
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
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
