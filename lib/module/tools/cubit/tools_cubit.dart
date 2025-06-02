import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tools_state.dart';

class ToolsCubit extends Cubit<ToolsState> {
  ToolsCubit() : super(ToolsInitial());
}
