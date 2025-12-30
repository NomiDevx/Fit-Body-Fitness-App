import 'package:fbfitnessapp/widgets/articleCard.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';

class Articlerecommendation extends StatelessWidget {
  // const Articlerecommendation({super.key});
  final List<Article> articles;

  Articlerecommendation({required this.articles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final articleData = articles[index];
          return Articlecard(article: articleData);
        },
      ),
    );
    ;
  }
}
