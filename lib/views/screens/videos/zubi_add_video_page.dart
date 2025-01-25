import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart' as cam;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:zubi/controllers/upload_video_controller.dart';
import 'package:zubi/views/screens/videos/confirm_screen.dart';
import 'package:zubi/views/screens/videos/search_music_page(2).dart';

class ZubiAddNewVideoPage extends StatefulWidget {
  const ZubiAddNewVideoPage({super.key});

  @override
  _ZubiAddNewVideoPage createState() => _ZubiAddNewVideoPage();
}

class _ZubiAddNewVideoPage extends State<ZubiAddNewVideoPage> {
  final UploadVideoController uploadController = Get.put(UploadVideoController());

  cam.CameraController? _cameraController;
  VideoPlayerController? _videoPlayerController;
  XFile? _videoFile;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void initializeCamera() async {
    final cameras = await cam.availableCameras();
    _cameraController = cam.CameraController(cameras[0], cam.ResolutionPreset.high);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> recordVideo() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        // Start recording the video
        await _cameraController?.startVideoRecording();

        // Wait for specific duration
        await Future.delayed(const Duration(seconds: 10));

        // Stop recording and get the file
        final XFile videoFile = await _cameraController!.stopVideoRecording();

        // Navigate to the upload confirmation page
        navigateToUploadPage(videoFile.path);
      } catch (e) {
        print("Error during video recording: $e");
      }
    }
  }

  Future<void> pickVideoFromDevice(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      navigateToUploadPage(video.path);
    }
  }

  void navigateToUploadPage(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          videoFile: File(videoPath),
          videoPath: videoPath,
        ),
      ),
    );
  }

  void uploadVideo(String songName, String caption, String videoPath) async {
    await uploadController.uploadVideo(songName, caption, videoPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            cam.CameraPreview(_cameraController!),
          if (_videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController!),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.music_note, color: Colors.white, size: 40),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchForMusicPage()),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: recordVideo,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.videocam, color: Colors.white, size: 40),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload_file,
                          color: Colors.white, size: 40),
                      onPressed: () => pickVideoFromDevice(ImageSource.gallery, context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => pickVideoFromDevice(ImageSource.gallery, context),
                  child: const Text(
                    "Upload from Gallery",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: () {
                // Placeholder to navigate to another page or perform next step
              },
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.purple, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
