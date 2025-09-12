enum AppRouteEnum {
  welcomePage,
  homePage,
  generalPage,
  readingPage,
  listeningPage,
  speakingPage,
  writingPage,
  grammarAndVocabularyPage,
  tipPage,
  infoPage,
  readingP1Page,
  readingP2vs3Page,
  readingP4Page,
  readingP5Page,
  listeningP1Page,
  listeningP2Page,
  listeningP3Page,
  listeningP4Page,
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.welcomePage:
        return "/welcome_page";

      case AppRouteEnum.homePage:
        return "/home_page";

      case AppRouteEnum.generalPage:
        return "/general_page";

      case AppRouteEnum.readingPage:
        return "/reading_page";

      case AppRouteEnum.listeningPage:
        return "/listening_page";

      case AppRouteEnum.speakingPage:
        return "/speaking_page";

      case AppRouteEnum.writingPage:
        return "/writing_page";

      case AppRouteEnum.grammarAndVocabularyPage:
        return "/grammar_and_vocabulary_page";

      case AppRouteEnum.tipPage:
        return "/tip_page";

      case AppRouteEnum.infoPage:
        return "/info_page";

      case AppRouteEnum.readingP1Page:
        return "/reading_p1_page";

      case AppRouteEnum.readingP2vs3Page:
        return "/reading_p2vs3_page";

      case AppRouteEnum.readingP4Page:
        return "/reading_p4_page";

      case AppRouteEnum.readingP5Page:
        return "/reading_p5_page";

      case AppRouteEnum.listeningP1Page:
        return "/listening_p1_page";

      case AppRouteEnum.listeningP2Page:
        return "/listening_p2_page";

      case AppRouteEnum.listeningP3Page:
        return "/listening_p3_page";

      case AppRouteEnum.listeningP4Page:
        return "/listening_p4_page";
    }
  }
}
