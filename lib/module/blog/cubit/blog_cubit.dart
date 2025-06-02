import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());
}
