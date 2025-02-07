import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraHandler extends StatefulWidget {
  final Function(Image, String) onImageCaptured;

  const CameraHandler({super.key, required this.onImageCaptured});

  @override
  CameraHandlerState createState() => CameraHandlerState();
}

class CameraHandlerState extends State<CameraHandler> {
  Image? _capturedImage;
  String? _imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85, // Adjust quality as needed (0-100)
      );

      if (photo != null) {
        setState(() {
          _capturedImage = Image.file(File(photo.path));
          _imagePath = photo.path;
        });
        
        // Call the callback with the captured image
        widget.onImageCaptured(_capturedImage!, _imagePath!);
      }
    } catch (e) {

      var contextVariable = context;
      
      // Handle any errors
      if (contextVariable.mounted) {
      showDialog(
        context: contextVariable,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to capture image: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(contextVariable),
              child: const Text('OK'),
            ),
          ],
        ),
      );}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}