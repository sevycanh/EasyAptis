sealed class WelcomeEvent {}

class PageChangedEvent extends WelcomeEvent {
  final int page;

  PageChangedEvent(this.page);
}

class NextPageEvent extends WelcomeEvent {}