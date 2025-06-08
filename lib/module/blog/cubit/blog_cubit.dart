import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/blog/model/blogd_model.dart';
import 'package:shishu_sanskar/module/blog/repo/blogs_repo.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());

  BlogsRepo blogsRepo = BlogsRepo();
  List<BlogsModel> blogList = [];
  int pageNumber = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  Future<void> getBlogs(
    BuildContext context, {
    required String search,
    bool isRefresh = false,
  }) async {
    if (isLoading || !hasMoreData) return;

    if (isRefresh) {
      pageNumber = 1;
      hasMoreData = true;
      blogList.clear();
      emit(BlogLoading());
    }

    isLoading = true;
    Response response = await blogsRepo.getBlogs(
      context,
      search: search,
      page: pageNumber.toString(),
    );

    if (response.data['success'] == true) {
      List<BlogsModel> newBlogList =
          (response.data['data']['data'] as List)
              .map((e) => BlogsModel.fromJson(e))
              .toList();

      if (newBlogList.isNotEmpty) {
        blogList.addAll(newBlogList);
        pageNumber++;
      } else {
        hasMoreData = false;
      }
      emit(GetBlogListState(blogList: List.from(blogList)));
    }

    isLoading = false;
  }
}
