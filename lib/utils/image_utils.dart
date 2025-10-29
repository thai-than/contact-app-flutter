import 'dart:io';
import 'package:flutter/material.dart';

/// Returns the correct [ImageProvider] for the given [path].
/// 
/// - If [path] is null or empty → returns default placeholder.
/// - If [path] starts with `/data/` or file exists → returns [FileImage].
/// - Otherwise → assumes it's an asset and returns [AssetImage].
ImageProvider getImageProvider(String? path, {String fallbackAsset = 'assets/images/avatar.png'}) {
  if (path == null || path.isEmpty) {
    return AssetImage(fallbackAsset);
  }

  // Check if it's a local file path
  final file = File(path);
  if (path.startsWith('/data/') || file.existsSync()) {
    return FileImage(file);
  }

  // Otherwise assume it's an asset path
  return AssetImage(path);
}
