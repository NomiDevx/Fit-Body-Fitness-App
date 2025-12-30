import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbfitnessapp/theme/colors.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers for each field
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isFavorite = false;
  bool _isArticle = true;
  bool _isLoading = false;

  Future<void> _submitArticle() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
        await _firestore.collection('articles').add({
          'id': _idController.text.trim(),
          'title': _titleController.text.trim(),
          'imageUrl': _imageUrlController.text.trim(),
          'description': _descriptionController.text.trim(),
          'isFavorite': _isFavorite,
          'isArticle': _isArticle,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Navigator.of(context).pop(); // Close the screen after submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Article added successfully!'),
            backgroundColor: AppColors.secondary,
          ),
        );
        
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: Text(
            'Add New Article',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Text(
              'Create Article',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Add informative articles to help users with fitness tips, nutrition advice, and health knowledge.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 26),
            Container(
              height: 650, // Adjusted height for article fields
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID Field
                      _buildFormField(
                        label: 'Article ID',
                        hint: 'e.g. a1',
                        controller: _idController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Title Field
                      _buildFormField(
                        label: 'Title',
                        hint: 'e.g. 10 Tips for Better Sleep',
                        controller: _titleController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Image URL Field
                      _buildFormField(
                        label: 'Image URL',
                        hint: 'https://example.com/article.jpg',
                        controller: _imageUrlController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                          if (!Uri.tryParse(value)!.hasAbsolutePath) return 'Invalid URL';
                          return null;
                        },
                      ),
                      
                      // Description Field
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            controller: _descriptionController,
                            maxLines: 5, // More lines for article content
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Article content...',
                            ),
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      
                      // Toggle Switches
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Is Favorite',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Switch(
                                  value: _isFavorite,
                                  onChanged: (value) => setState(() => _isFavorite = value),
                                  activeColor: AppColors.secondary,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Is Article',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Switch(
                                  value: _isArticle,
                                  onChanged: (value) => setState(() => _isArticle = value),
                                  activeColor: AppColors.secondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator(color: AppColors.secondary)
                : OutlinedButton(
                    onPressed: _submitArticle,
                    child: Text(
                      'Save Article',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
              validator: validator,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}