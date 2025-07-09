import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../model/laptop_response.dart';
import 'laptop_state.dart';

class LaptopCubit extends Cubit<LaptopState> {
  LaptopCubit() : super(LaptopInitial());

  Future<void> getLaptop() async {
    emit(Laptoploading());

    try {
      final response = await Dio().get("https://elwekala.onrender.com/product/Laptops");

      final data = response.data as Map<String, dynamic>;

      final laptopResponse = LapTopModel.fromJson(data);

      emit(LaptopSuccess(laptopResponse));
    } catch (e) {
      emit(LaptopFailure(e.toString()));
    }
  }
}
