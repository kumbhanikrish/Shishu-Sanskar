part of 'blog_cubit.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class GetBlogListState extends BlogState {
  final List<BlogsModel> blogList;

  GetBlogListState({required this.blogList});
}

final class BlogLoading extends BlogState {}
