import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';



//لما الـ API يطلب ملف (form-data)
//وليس String
Future upLoadImageToApi(XFile image)async{
  return MultipartFile.fromFile(image.path,
  filename: image.path.split('/').last
  );
}


