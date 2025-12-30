class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  bool isFavourite;
  bool isArticle;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.isFavourite = false,
    this.isArticle = true,
  });
}
