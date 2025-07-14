import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/blog/model/blogd_model.dart';
import 'package:shishu_sanskar/module/blog/repo/blogs_repo.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());

  BlogsRepo blogsRepo = BlogsRepo();
  int currentPage = 1;
  bool isLastPage = false;

  List<BlogsModel> blogList = [];
  List<BlogsModel> moreBlogList = [];

  getBlogs(BuildContext context, {required String search}) async {
    currentPage = 1;
    isLastPage = false;

    emit(BlogLoading());

    final response = await blogsRepo.getBlogs(
      context,
      search: search,
      page: currentPage.toString(),
    );

    if (response.data['success'] == true) {
      final data = response.data['data'];
      final List newData = data['data'] ?? [];

      blogList = newData.map((e) => BlogsModel.fromJson(e)).toList();

      // Check if this is the last page
      isLastPage = data['next_page_url'] == null;

      emit(GetBlogListState(blogList: blogList));
    } else {
      emit(BlogFailedState());
    }
  }

  loadMoreBlogs(BuildContext context, {required String search}) async {
    if (isLastPage) return;

    emit(BlogLoading());

    try {
      currentPage += 1;

      final response = await blogsRepo.getBlogs(
        context,
        search: search,
        page: currentPage.toString(),
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        final List newData = data['data'] ?? [];

        moreBlogList = newData.map((e) => BlogsModel.fromJson(e)).toList();

        blogList.addAll(moreBlogList);

        isLastPage = data['next_page_url'] == null;

        emit(MoreGetBlogListState(blogList: blogList));
      } else {
        emit(MoreGetBlogListState(blogList: blogList));
      }
    } catch (e) {
      emit(BlogFailedState());
    }
  }

  void init() {
    emit(BlogInitial());
  }
}
