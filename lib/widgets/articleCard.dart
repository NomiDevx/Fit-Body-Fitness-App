import 'package:fbfitnessapp/models/article_model.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/article_provider.dart';

class Articlecard extends StatelessWidget {
  // const Articlecard({super.key});
  final Article article;
  Articlecard({required this.article});

  @override
  Widget build(BuildContext context) {
    // final articleData = Provider.of<ArticleProvider>(context);
    // final articles = articleData.articles;
    return Container(
      // height: 90,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8), // Added margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white70),
        color: Colors.black45,
        boxShadow: [
          // Added shadow for better card appearance
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  
                  child: Image.network(article.imageUrl, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article.title,
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              article.isFavourite ? Icons.star : Icons.star_border,
              color: AppColors.secondary,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
