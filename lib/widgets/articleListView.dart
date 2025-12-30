import 'package:fbfitnessapp/models/article_model.dart';
import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Articlelistview extends StatelessWidget {
  final Article article;

  const Articlelistview({super.key, required this.article});


  @override
  Widget build(BuildContext context) {
    


    return Card(
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Article details on the left
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Image on the right with favorite indicator
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    article.imageUrl,
                    fit: BoxFit.cover,
                    width: 180,
                    height: 120,
                  ),
                ),
                if (article.isFavourite)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                      size: 20,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
