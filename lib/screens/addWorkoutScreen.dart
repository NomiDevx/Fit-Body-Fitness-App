import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbfitnessapp/theme/colors.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers for each field
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _exercisesCountController = TextEditingController();

  bool _isFavorite = false;
  bool _isVideo = true;
  bool _isLoading = false;

  Future<void> _submitWorkout() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
        await _firestore.collection('workouts').add({
          'id': _idController.text.trim(),
          'title': _titleController.text.trim(),
          'duration': _durationController.text.trim(),
          'calories': _caloriesController.text.trim(),
          'imageUrl': _imageUrlController.text.trim(),
          'videoUrl': _videoUrlController.text.trim(),
          'description': _descriptionController.text.trim(),
          'exercisesCount': int.tryParse(_exercisesCountController.text.trim()) ?? 0,
          'isFavorite': _isFavorite,
          'isVideo': _isVideo,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Workout added successfully!'),
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
    _durationController.dispose();
    _caloriesController.dispose();
    _imageUrlController.dispose();
    _videoUrlController.dispose();
    _descriptionController.dispose();
    _exercisesCountController.dispose();
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
            'Add New Workout',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Text(
              'Create Workout',
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
                'Add new workout details to help users achieve their fitness goals. Provide accurate information for best results.',
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
              height: 900, // Adjusted height for more fields
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
                        label: 'Workout ID',
                        hint: 'e.g. w4',
                        controller: _idController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Title Field
                      _buildFormField(
                        label: 'Title',
                        hint: 'e.g. Core Strength',
                        controller: _titleController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Duration Field
                      _buildFormField(
                        label: 'Duration',
                        hint: 'e.g. 10 Minutes',
                        controller: _durationController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Calories Field
                      _buildFormField(
                        label: 'Calories',
                        hint: 'e.g. 100 Kcal',
                        controller: _caloriesController,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                      
                      // Image URL Field
                      _buildFormField(
                        label: 'Image URL',
                        hint: 'https://example.com/image.jpg',
                        controller: _imageUrlController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                          if (!Uri.tryParse(value)!.hasAbsolutePath) return 'Invalid URL';
                          return null;
                        },
                      ),
                      
                      // Video URL Field
                      _buildFormField(
                        label: 'Video URL',
                        hint: 'https://example.com/video.mp4',
                        controller: _videoUrlController,
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
                            maxLines: 3,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Workout description...',
                            ),
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      
                      // Exercises Count Field
                      _buildFormField(
                        label: 'Exercises Count',
                        hint: 'e.g. 6',
                        controller: _exercisesCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                          if (int.tryParse(value) == null) return 'Invalid number';
                          return null;
                        },
                      ),
                      
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
                                  'Has Video',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Switch(
                                  value: _isVideo,
                                  onChanged: (value) => setState(() => _isVideo = value),
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
                    onPressed: _submitWorkout,
                    child: Text(
                      'Save Workout',
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