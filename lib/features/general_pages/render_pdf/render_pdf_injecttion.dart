import 'package:easyaptis/features/general_pages/render_pdf/data/repositories/render_pdf_repository_impl.dart';
import 'package:easyaptis/features/general_pages/render_pdf/domain/repositories/render_pdf_repository.dart';
import 'package:easyaptis/features/general_pages/render_pdf/domain/usecases/get_render_pdf.dart';
import 'package:easyaptis/features/general_pages/render_pdf/presentation/bloc/render_pdf_bloc.dart';
import 'package:easyaptis/injection_container.dart';

initRenderPDFInjections() {
  // Bloc
  sl.registerFactory(() => RenderPDFBloc(sl()));
  // UseCase
  sl.registerLazySingleton(() => GetRenderPDF(sl()));
  // Repository
  sl.registerLazySingleton<RenderPDFRepository>(
    () => RenderPDFRepositoryImpl(sl()),
  );
}
