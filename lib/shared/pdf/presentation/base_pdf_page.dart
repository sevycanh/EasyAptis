import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'base_pdf_bloc.dart';

class BasePdfPage<B extends BasePdfBloc> extends StatefulWidget {
  final String title;
  final int? startPage;
  final int? endPage;

  const BasePdfPage({
    super.key,
    required this.title,
    this.startPage,
    this.endPage,
  });

  @override
  State<BasePdfPage<B>> createState() => _BasePdfPageState<B>();
}

class _BasePdfPageState<B extends BasePdfBloc> extends State<BasePdfPage<B>> {
  PDFViewController? _pdfViewController;
  int _currentPage = 0;
  int _totalPages = 0;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _currentPage = (widget.startPage ?? 1) - 1; // flutter_pdfview dùng index từ 0
  }

  void _nextPage() async {
    if (_pdfViewController == null) return;
    if (widget.endPage == null || _currentPage + 1 < widget.endPage!) {
      _currentPage++;
      await _pdfViewController!.setPage(_currentPage);
      setState(() {});
    }
  }

  void _previousPage() async {
    if (_pdfViewController == null) return;
    if (widget.startPage == null || _currentPage + 1 > widget.startPage!) {
      _currentPage--;
      await _pdfViewController!.setPage(_currentPage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BasePdfState>(
      builder: (context, state) {
        if (state.isLoading) return AppLoading();

        if (state.error != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: const Center(child: Text("Có lỗi xảy ra")),
          );
        }

        if (state.pdf != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              actions: [
                _buildPrevButton(),
                _buildPageCounter(),
                _buildNextButton(),
              ],
            ),
            body: Stack(
              children: [
                PDFView(
                  filePath: state.pdf!.localPath,
                  enableSwipe: false, // 🚫 Không cho vuốt
                  swipeHorizontal: true, // 🚫 Không cuộn ngang
                  autoSpacing: false, // 🚫 Không tự căn giữa
                  pageFling: false, // 🚫 Không có hiệu ứng quán tính
                  pageSnap: true, // 🧷 Giữ đúng 1 trang tại chỗ
                  defaultPage: (widget.startPage ?? 1) - 1,
                  fitPolicy: FitPolicy.BOTH, // 📄 Fit chiều ngang + dọc
                  onRender: (pages) async {
                    setState(() {
                      _totalPages = pages ?? 0;
                      _isReady = true;
                    });
                    // Nhảy đến trang bắt đầu (nếu có)
                    if (widget.startPage != null) {
                      await _pdfViewController?.setPage(widget.startPage! - 1);
                    }
                  },
                  onViewCreated: (controller) {
                    _pdfViewController = controller;
                  },
                  onPageChanged: (page, total) {
                    if (page != null) {
                      setState(() => _currentPage = page);
                    }
                  },
                ),
                if (!_isReady)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPageCounter() {
    final total = (widget.endPage != null && widget.startPage != null)
        ? (widget.endPage! - widget.startPage! + 1)
        : (_totalPages > 0 ? _totalPages : 1);
    final currentDisplay = (widget.startPage != null)
        ? (_currentPage + 1 - widget.startPage! + 1)
        : _currentPage + 1;

    return Center(
      child: Text(
        '$currentDisplay / $total',
        style: AppTextStyle.mediumBlack,
      ),
    );
  }

  Widget _buildPrevButton() {
    final isAtStart =
        widget.startPage != null && (_currentPage + 1) <= widget.startPage!;
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: isAtStart ? null : _previousPage,
      color: Colors.black,
    );
  }

  Widget _buildNextButton() {
    final isAtEnd =
        widget.endPage != null && (_currentPage + 1) >= widget.endPage!;
    return IconButton(
      icon: const Icon(Icons.arrow_forward),
      onPressed: isAtEnd ? null : _nextPage,
      color: Colors.black,
    );
  }
}