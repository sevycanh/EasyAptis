import 'package:easyaptis/shared/pdf/data/pdf_local_data_source.dart';
import 'package:easyaptis/shared/pdf/domain/entities/pdf_entity.dart';

import '../../domain/repositories/render_pdf_repository.dart';

class RenderPDFRepositoryImpl implements RenderPDFRepository {
  final PdfLocalDataSource dataSource;

  RenderPDFRepositoryImpl(this.dataSource);

  @override
  Future<PdfEntity> getGrammarPdf() async {
    // const id = "pdf";
    // final baseUrl = dotenv.env['BASE_PDF_URL'];
    // final url = "$baseUrl/grammar/test.pdf";
    // final path = await dataSource.getCachedPdf(id, url);
    // return PdfEntity(id: id, url: url, localPath: path);

    const assetPath = 'assets/pdf/gram_vocab_ea.pdf';
    const fileName = 'gram_vocab_ea.pdf';

    final path = await dataSource.getLocalPdf(assetPath, fileName);

    return PdfEntity(
      id: 'grammar_pdf',
      url: assetPath, 
      localPath: path,
    );
  }
}
