import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/configs/styles/app_text_style.dart';

class QuestionAnswerField extends StatefulWidget {
  final int partId;
  final int questionId;
  final String initialValue;
  final void Function(String) onChanged;
  final TextEditingController? controller; 

  const QuestionAnswerField({
    super.key,
    required this.partId,
    required this.questionId,
    required this.initialValue,
    required this.onChanged,
    this.controller,
  });

  @override
  State<QuestionAnswerField> createState() => _QuestionAnswerFieldState();
}

class _QuestionAnswerFieldState extends State<QuestionAnswerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);

    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void didUpdateWidget(covariant QuestionAnswerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); 
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        final wordCount = value.text.trim().isEmpty
            ? 0
            : value.text.trim().split(RegExp(r"\s+")).length;

        return TextFormField(
          controller: _controller,
          cursorColor: AppColors.primaryColor,
          style: AppTextStyle.largeBlack,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            hintText: "Enter your answer...",
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
          buildCounter: (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            return Text("$wordCount words", style: AppTextStyle.mediumBlack);
          },
        );
      },
    );
  }
}
