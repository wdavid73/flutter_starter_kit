import 'package:flutter_test/flutter_test.dart';
import 'package:platform_media/platform_media.dart';

void main() {
  test('CameraGalleryServiceImpl satisfies the CameraGalleryService contract',
      () {
    expect(CameraGalleryServiceImpl(), isA<CameraGalleryService>());
  });
}
