import 'package:easyaptis/injection_container.dart';
import 'package:easyaptis/shared/pdf/data/pdf_local_data_source.dart';

initPDFInjections() {
  // DataSource
  sl.registerLazySingleton<PdfLocalDataSource>(() {
    return PdfLocalDataSourceImpl();
  });

}
