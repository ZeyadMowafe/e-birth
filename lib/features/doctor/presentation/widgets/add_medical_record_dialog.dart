import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ebirth/core/widgets/app_toast.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import '../cubit/add_medical_record_cubit.dart';
import '../cubit/add_medical_record_state.dart';

class AddMedicalRecordDialog extends StatefulWidget {
  final int childId;
  final String childName;

  const AddMedicalRecordDialog({
    super.key,
    required this.childId,
    required this.childName,
  });

  @override
  State<AddMedicalRecordDialog> createState() => _AddMedicalRecordDialogState();
}

class _AddMedicalRecordDialogState extends State<AddMedicalRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _medicineController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _selectedImagePaths = [];

  @override
  void dispose() {
    _medicineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result != null) {
        setState(() {
          _selectedImagePaths.addAll(result.paths.whereType<String>());
        });
      }
    } catch (e) {
      debugPrint('File Picker Error: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        AppToast.error(context, l10n.addRecordFileError(e.toString().split(':').last));
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImagePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.addRecordTitle,
                      style: GoogleFonts.readexPro(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.addRecordForChild(widget.childName),
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),
                
                Text(
                  l10n.addRecordMedicine,
                  style: GoogleFonts.readexPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _medicineController,
                  decoration: InputDecoration(
                    hintText: l10n.addRecordMedicineHint,
                    hintStyle: GoogleFonts.readexPro(fontSize: 13, color: const Color(0xFF94A3B8)),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? l10n.addRecordMedicineRequired : null,
                ),
                const SizedBox(height: 16),
                
                Text(
                  l10n.addRecordDescription,
                  style: GoogleFonts.readexPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.addRecordDescriptionHint,
                    hintStyle: GoogleFonts.readexPro(fontSize: 13, color: const Color(0xFF94A3B8)),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? l10n.addRecordDescriptionRequired : null,
                ),
                const SizedBox(height: 20),

                Text(
                  l10n.addRecordImages,
                  style: GoogleFonts.readexPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                
                if (_selectedImagePaths.isNotEmpty)
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImagePaths.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                image: DecorationImage(
                                  image: FileImage(File(_selectedImagePaths[index])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, size: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickImages,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF8FAFC),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.add_photo_alternate_outlined, color: Color(0xFF4E8B97)),
                        const SizedBox(height: 4),
                        Text(
                          l10n.addRecordUploadImages,
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                            color: const Color(0xFF4E8B97),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                BlocConsumer<AddMedicalRecordCubit, AddMedicalRecordState>(
                  listener: (context, state) {
                    if (state is AddMedicalRecordSuccess) {
                      AppToast.success(context, l10n.addRecordSuccess);
                      Navigator.pop(context);
                    } else if (state is AddMedicalRecordError) {
                      AppToast.error(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state is AddMedicalRecordLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  if (_selectedImagePaths.isEmpty) {
                                    AppToast.error(context, l10n.addRecordImageRequired);
                                    return;
                                  }
                                  
                                  context.read<AddMedicalRecordCubit>().addMedicalRecord(
                                        childId: widget.childId,
                                        medicine: _medicineController.text,
                                        description: _descriptionController.text,
                                        imagePaths: _selectedImagePaths,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4E8B97),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: state is AddMedicalRecordLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                                : Text(
                                    l10n.addRecordSubmit,
                                style: GoogleFonts.readexPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
