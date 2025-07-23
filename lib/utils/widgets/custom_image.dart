import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextFiledImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final Color? color;
  const CustomTextFiledImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 20,
        width: width ?? 20,
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            image,
            color: color ?? AppColor.themePrimaryColor2,
            height: height ?? 20,
            width: width ?? 20,
          ),
        ),
      ),
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? 22.w,
      height: height ?? 11.h,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: AppColor.themePrimaryColor2,
              ),
            ),
          ),
      errorWidget:
          (context, url, error) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(AppImage.imageError, fit: BoxFit.cover),
          ),
    );
  }
}
