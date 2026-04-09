import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:fbfitnessapp/widgets/articleListView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../theme/colors.dart';

class ArticlesLayoutScreen extends StatelessWidget {
  final List<Article> articles;

  const ArticlesLayoutScreen({Key? key, required this.articles})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Articles & Tips',
            style: TextStyle(
              color: AppColors.secondary,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Discover Fresh Knowledge: Elevate Your Training',
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Articlelistview(article: articles[index]);
            },
          ),
        ],
      ),
    );
  }
}
