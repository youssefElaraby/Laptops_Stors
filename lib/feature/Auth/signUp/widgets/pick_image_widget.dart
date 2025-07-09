import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../view_model/sign_up_cubit.dart';

class PickImageWidget extends StatelessWidget {
  const  PickImageWidget({super.key});

  Future<void> _showImagePickerOptions(BuildContext context) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a photo"),
                onTap: () async {
                  final image = await picker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context);
                  if (image != null) {
                    context.read<SignUpCubit>().upLoadProfilePicture(image);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from gallery"),
                onTap: () async {
                  final image = await picker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context);
                  if (image != null) {
                    context.read<SignUpCubit>().upLoadProfilePicture(image);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final selectedImage = cubit.profilePic;

        return SizedBox(
          width: 130,
          height: 130,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: selectedImage != null
                    ? FileImage(File(selectedImage.path))
                    : const AssetImage("assets/images/avatar.png") as ImageProvider,
              ),

              //  عرض لودينج لو الصورة بتترفع
              if (cubit.isUploadingImage)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              //  اخفاء الكاميرا بعد ما الصورة تترفع وتخلص
              if (!cubit.isImageUploaded)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () => _showImagePickerOptions(context),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.camera_alt_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
