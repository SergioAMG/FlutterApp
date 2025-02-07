
class Message {
  final String text;
  final String? imagePath;
  final bool isSender;
  final DateTime timestamp;

  Message({
    required this.text, 
    required this.imagePath,
    required this.isSender, 
    required this.timestamp
  });
}
