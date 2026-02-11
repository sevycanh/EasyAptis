import 'package:easyaptis/features/general_pages/render_pdf/presentation/bloc/render_pdf_bloc.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:easyaptis/shared/pdf/presentation/base_pdf_bloc.dart';
import 'package:easyaptis/shared/pdf/presentation/base_pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RenderPDFPage extends StatelessWidget {
  final String title;
  final int? startPage;
  final int? endPage;
  const RenderPDFPage({
    super.key,
    required this.title,
    this.startPage,
    this.endPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RenderPDFBloc>()..add(LoadPdf()),
      child: 
      BasePdfPage<RenderPDFBloc>(
        title: title,
        startPage: startPage,
        endPage: endPage,
      ),
    );
  }
}
