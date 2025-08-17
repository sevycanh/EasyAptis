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
    }
  }
}
