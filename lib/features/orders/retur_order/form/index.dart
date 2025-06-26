import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/retur_order/form/void_handle_post.dart';
import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/models/retur_body_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ReturFormAdd extends ConsumerStatefulWidget {
  final OrderModel data;
  const ReturFormAdd({super.key, required this.data});

  @override
  ConsumerState<ReturFormAdd> createState() => _ReturFormAddState();
}

class _ReturFormAddState extends ConsumerState<ReturFormAdd> {
  final quantityController = TextEditingController();
  final reasonController = TextEditingController();
  final List<File> selectedImages = [];
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1024,
      );

      if (images.isNotEmpty) {
        setState(() {
          for (var image in images) {
            selectedImages.add(File(image.path));
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error memilih gambar: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Form Pengajuan Retur",
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            InputDefault(
              label: 'Jumlah Retur',
              hintText: 'Masukkan jumlah retur',
              controller: quantityController,
              // errorText: formState.emailError,
              keyboardType: TextInputType.number,
              // onChanged: form.updateEmail,
              onChanged: (vales) {},
            ),

            // TextArea
            const Text(
              'Alasan Retur',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: reasonController,
              maxLines: 5,
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Masukkan alasan retur',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFFFFD700), // myColors.yellow
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Image Upload Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Gambar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Upload Button
                InkWell(
                  onTap: _pickImages,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pilih Gambar',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Maksimal 10 gambar',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Image Preview Section
                if (selectedImages.isNotEmpty) ...[
                  const Text(
                    'Preview Gambar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                selectedImages[index],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Delete Button
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
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
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),

            BtnDefault(
                name: "Kirim Pengajuan",
                onTap: () {
                  final data = ReturOrderBodyRequestModel(
                    orderNumber: widget.data.orderNumber,
                    quantity: int.parse(quantityController.text),
                    description: reasonController.text,
                    images: selectedImages,
                  );
                  handlePostReturOrder(context, ref, data);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    quantityController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
