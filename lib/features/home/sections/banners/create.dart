import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'dart:io';

class BannerCreate extends ConsumerStatefulWidget {
  const BannerCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerCreateState();
}

class _BannerCreateState extends ConsumerState<BannerCreate> {
  final _imageController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _selectedImagePath;
  String? _imageError;
  bool _isImageSelected = false;

  void _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
          _isImageSelected = true;
          _imageError = null;
        });

        // Validasi gambar yang dipilih
        _validateImage(image.path);
      }
    } catch (e) {
      setState(() {
        _imageError = "Gagal memilih gambar: ${e.toString()}";
      });
    }
  }

  void _validateImage(String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      setState(() {
        _imageError = "Gambar banner wajib diisi";
      });
      return;
    }

    // Validasi ekstensi file
    final extension = filePath.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png'].contains(extension)) {
      setState(() {
        _imageError = "Format file harus jpg, jpeg, atau png";
      });
      return;
    }

    setState(() {
      _imageError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Tambah Banner",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              // input image
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gambar Banner',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: _imageError != null ? Colors.red : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _isImageSelected && _selectedImagePath != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  File(_selectedImagePath!),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                        color: Colors.grey[600],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImagePath = null;
                                      _isImageSelected = false;
                                      _imageError = null;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 50,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 8),
                                  TextNormal(
                                    text: "Pilih Gambar",
                                    color: Colors.grey[600]!,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 4),
                                  TextNormal(
                                    text: "JPG, JPEG, PNG (Max 2MB)",
                                    color: Colors.grey[500]!,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  if (_imageError != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _imageError!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
              InputDefault(
                label: 'Nama Banner',
                hintText: 'Masukkan nama banner',
                controller: _nameController,
                errorText: "",
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    _nameController.text = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
