sealed class WClubsEvent {}

class LoadClubs extends WClubsEvent {
  final int? page;
  final int? limit;

  LoadClubs({this.page, this.limit});
}

class SearchClubs extends WClubsEvent {
  final String keyword;
  SearchClubs(this.keyword);
}