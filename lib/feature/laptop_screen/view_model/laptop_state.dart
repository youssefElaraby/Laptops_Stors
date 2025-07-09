
import '../model/laptop_response.dart';

abstract class LaptopState {}

final class LaptopInitial extends LaptopState {}
final class Laptoploading extends LaptopState {}
final class LaptopSuccess extends LaptopState {
  final LapTopModel laps;
  LaptopSuccess(this.laps);
}
final class LaptopFailure extends LaptopState {
  final String message;
  LaptopFailure(this.message);
}
