import 'package:easyaptis/shared/pdf/domain/entities/pdf_entity.dart';

abstract class RenderPDFRepository {
  Future<PdfEntity> getGrammarPdf();
}