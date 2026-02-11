import 'package:easyaptis/shared/pdf/presentation/base_pdf_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_render_pdf.dart';

class RenderPDFBloc extends BasePdfBloc {
  final GetRenderPDF getGrammarPdf;

  RenderPDFBloc(this.getGrammarPdf) {
    on<LoadPdf>(_onLoadPdf);
  }

  Future<void> _onLoadPdf(LoadPdf event, Emitter<BasePdfState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future.delayed(const Duration(seconds: 3));
      final pdf = await getGrammarPdf();
      emit(state.copyWith(isLoading: false, pdf: pdf));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
