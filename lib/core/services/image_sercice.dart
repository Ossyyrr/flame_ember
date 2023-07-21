import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageService {
  static Future getImageSize(String asset) async {
    // Cambia según el device (dpi)
    final ByteData data = await rootBundle.load(asset);
    final Uint8List bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    double width = image.width.toDouble(); //px
    double height = image.height.toDouble(); //px

    return (width, height);
  }
}
