import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/core/widgets/app_toast.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_bloc.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_event.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_state.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/widgets/question_answer_field.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:easyaptis/shared/suggest_bottom_sheet/models/suggest_ui_model.dart';
import 'package:easyaptis/shared/suggest_bottom_sheet/widgets/suggest_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WClubsDetailPage
    extends
        BaseBlocWidget<WClubsDetailEvent, WClubsDetailState, WClubsDetailBloc> {
  WClubsDetailPage({super.key, required this.wClubsEntity})
    : super(sl<WClubsDetailBloc>());

  // final int clubId;
  final WClubsEntity wClubsEntity;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadClubDetails(entity: wClubsEntity));
  }

  @override
  void onStateChanged(BuildContext context, WClubsDetailState state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    WClubsDetailBloc bloc,
    WClubsDetailState state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget body;

    if (state.error.isNotEmpty) {
      body = Center(child: Text("Có lỗi xảy ra!"));
    } else if (state.topic == null) {
      body = const Center(child: Text("Chưa có dữ liệu"));
    } else {
      body = _buildBody(context, bloc, state);
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.topic?.name ?? ""),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: body,
        bottomNavigationBar: (state.error.isNotEmpty && state.topic == null)
            ? null
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "Back",
                          textStyle: state.currentPart > 1
                              ? null
                              : AppTextStyle.largeBlack.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGray,
                                  letterSpacing: 1,
                                ),
                          color: AppColors.pastel,
                          onPressed: state.currentPart > 1
                              ? () => bloc.add(PreviousPart())
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          text: "Next",
                          textStyle:
                              state.topic != null &&
                                  state.currentPart < state.topic!.parts.length
                              ? null
                              : AppTextStyle.largeBlack.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGray,
                                  letterSpacing: 1,
                                ),
                          color: AppColors.green,
                          onPressed:
                              state.topic != null &&
                                  state.currentPart < state.topic!.parts.length
                              ? () => bloc.add(NextPart())
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WClubsDetailBloc bloc,
    WClubsDetailState state,
  ) {
    final part = state.topic!.parts["${state.currentPart}"]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Part ${state.currentPart} of ${state.topic!.parts.length}\n(${state.currentPart == 1
                      ? '1-5'
                      : state.currentPart == 2
                      ? '20-30'
                      : state.currentPart == 3
                      ? '30-40'
                      : '50 & 120-150'} words)",
                  style: AppTextStyle.xLargeBlackBold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.lightbulb_outline),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _showSuggestBottomSheet(context, state);
                },
              ),
              // IconButton(
              //   icon: Icon(
              //     state.showCopyButtons
              //         ? Icons.remove_circle_outline_sharp
              //         : Icons.copyright,
              //   ),
              //   visualDensity: VisualDensity.compact,
              //   padding: EdgeInsets.zero,
              //   onPressed: () => bloc.add(ToggleCopyButtons()),
              // ),
            ],
          ),
          const SizedBox(height: 16),
          if (part.announcement != null) ...[
            Text(
              part.announcement!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
          ...part.questions.map((q) {
            final savedAnswer = state.answers[state.currentPart]?[q.id] ?? "";
            final controller = TextEditingController(text: savedAnswer);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SelectableText(
                        "${q.id}. ${q.text}",
                        style: AppTextStyle.xLargeBlackBold,
                      ),
                    ),
                    if (state.showCopyButtons)
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: q.text));
                          AppToast.showSuccess(context, message: "Đã sao chép");
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: QuestionAnswerField(
                        partId: state.currentPart,
                        questionId: q.id,
                        initialValue: savedAnswer,
                        controller: controller,
                        onChanged: (value) {
                          bloc.add(
                            UpdateAnswer(
                              partId: state.currentPart,
                              questionId: q.id,
                              answer: value,
                            ),
                          );
                        },
                      ),
                    ),
                    if (state.showCopyButtons)
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: controller.text),
                          );
                          AppToast.showSuccess(context, message: "Đã sao chép");
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }
}

void _showSuggestBottomSheet(BuildContext context, WClubsDetailState state) {
  final part = state.topic!.parts["${state.currentPart}"]!;

  final suggestions = part.questions.map((q) {
    return SuggestUiModel(
      id: q.id.toString(),
      title: q.text,
      suggestion: q.suggestion,
    );
  }).toList();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: AppColors.white,
    builder: (_) => SuggestBottomSheet(suggestions: suggestions),
  );
}
