import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage; // Lưu ảnh đã chọn

  File? get selectedImage => _selectedImage;

  set selectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  // chọn ảnh từ camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners(); // Thông báo cập nhật UI
    }
  }

  // chọn ảnh từ thư viện
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
    }
    notifyListeners();
  }

}
