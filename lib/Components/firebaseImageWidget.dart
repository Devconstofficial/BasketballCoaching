import 'package:basketball_coaching/config/firebaseStorage.dart';
import 'package:flutter/material.dart';

class FirebaseNetworkImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorBuilder;

  const FirebaseNetworkImage({
    required this.imagePath,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.fill,
    this.placeholder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageUrl(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ?? const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return errorBuilder ?? Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final imageUrl = snapshot.data!;
          return Image(
            image: NetworkImage(imageUrl),
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return const SizedBox(); 
        }
      },
    );
  }
}
