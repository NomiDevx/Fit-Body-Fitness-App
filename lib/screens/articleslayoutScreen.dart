import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:fbfitnessapp/widgets/articleListView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';

class ArticlesLayoutScreen extends StatefulWidget {
  final List<Article> articles;

  const ArticlesLayoutScreen({Key? key, required this.articles})
    : super(key: key);

  @override
  State<ArticlesLayoutScreen> createState() => _ArticlesLayoutScreenState();
}

class _ArticlesLayoutScreenState extends State<ArticlesLayoutScreen> {
  int selectedIcon = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Consumer<ArticleProvider>(
          builder: (context, work, child) {
            return ListView.builder(
              itemCount: work.articles.length,
              itemBuilder: (context, index) {
                return Articlelistview(article: work.articles[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
