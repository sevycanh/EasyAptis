import 'package:easyaptis/features/general_pages/render_pdf/domain/repositories/render_pdf_repository.dart';
import 'package:easyaptis/shared/pdf/domain/entities/pdf_entity.dart';

class GetRenderPDF {
  final RenderPDFRepository repo;
  GetRenderPDF(this.repo);

  Future<PdfEntity> call() async => await repo.getGrammarPdf();
}
