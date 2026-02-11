import 'package:easyaptis/shared/pdf/domain/entities/pdf_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePdfEvent {}

class LoadPdf extends BasePdfEvent {}

class BasePdfState {
  final bool isLoading;
  final String? error;
  final PdfEntity? pdf;

  BasePdfState({
    this.isLoading = false,
    this.error,
    this.pdf,
  });

  BasePdfState copyWith({
    bool? isLoading,
    String? error,
    PdfEntity? pdf,
  }) {
    return BasePdfState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      pdf: pdf ?? this.pdf,
    );
  }
}

abstract class BasePdfBloc extends Bloc<BasePdfEvent, BasePdfState> {
  BasePdfBloc() : super(BasePdfState());
}
