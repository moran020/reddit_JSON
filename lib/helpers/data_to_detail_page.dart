// данные, передаваемые на следующий экран
class DataToDetailPage {
  final String title;
  final String thumbnail;
  final int? ups;
  final String selftext;

  DataToDetailPage({
    required this.title,
    required this.thumbnail,
    required this.ups,
    required this.selftext,
  });
}
