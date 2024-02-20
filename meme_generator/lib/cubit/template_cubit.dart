import 'package:bloc/bloc.dart';

class TemplateCubit extends Cubit<int> {
  TemplateCubit() : super(0);

  void updateTemplate(int template) {
    emit(template);
  }
}
