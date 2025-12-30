import 'package:fbfitnessapp/models/workoutModel.dart';
import 'package:fbfitnessapp/providers/workoutProvider.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class Resourcesplayscreen extends StatefulWidget {
  final String workoutId;
  Resourcesplayscreen({required this.workoutId});

  @override
  State<Resourcesplayscreen> createState() => _ResourcesplayscreenState();
}

class _ResourcesplayscreenState extends State<Resourcesplayscreen> {
  int selectedIcon = -1;
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  late Workout _currentWorkout;

  @override
  void initState() {
    super.initState();
    // Get the workout data first
    _currentWorkout = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).workouts.firstWhere((w) => w.id == widget.workoutId);

    // Initialize video controller with the workout's video URL
    _videoController = VideoPlayerController.network(
        _currentWorkout.videoUrl, // Use the workout's videoUrl
      )
      ..initialize()
          .then((_) {
            setState(() {
              _totalDuration = _videoController.value.duration;
              _videoController.addListener(_updateVideoStatus);
              _videoController.play(); // Auto-play when initialized
              _isPlaying = true;
            });
          })
          .catchError((error) {
            print("Video initialization error: $error");
            // Show error to user if needed
          });
  }

  void _updateVideoStatus() {
    if (mounted) {
      setState(() {
        _currentPosition = _videoController.value.position;
        _isPlaying = _videoController.value.isPlaying;
      });
    }
  }

  @override
  void dispose() {
    _videoController.removeListener(_updateVideoStatus);
    _videoController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _currentWorkout.title, // Show workout title in app bar
        selectedIndex: selectedIcon,
        onIconTap: (index) {
          setState(() {
            selectedIcon = index;
          });
        },
      ),
      body: Container(
        color: AppColors.primary,
        child: Stack(
          children: [
            // Video with TikTok-like ratio (9:16)
            Center(
              child:
                  _videoController.value.isInitialized
                      ? AspectRatio(
                        aspectRatio:
                            _videoController.value.aspectRatio > 0
                                ? _videoController.value.aspectRatio
                                : 9 / 16, // Fallback ratio
                        child: VideoPlayer(_videoController),
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            'Loading workout video...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
            ),

            // Video Controls
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    _isPlaying
                        ? _videoController.play()
                        : _videoController.pause();
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: _isPlaying ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Video Timeline/Progress Bar
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Slider(
                      value: _currentPosition.inSeconds.toDouble(),
                      min: 0,
                      max: _totalDuration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _videoController.seekTo(
                            Duration(seconds: value.toInt()),
                          );
                        });
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(_totalDuration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
