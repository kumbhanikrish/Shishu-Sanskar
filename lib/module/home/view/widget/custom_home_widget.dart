import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/blog/cubit/blog_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

customTitleAnsSeeAll({
  required String title,
  required void Function() onTap,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: title,
            fontSize: fontSize ?? 12,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? AppColor.seeAllTitleColor,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 14, right: 20),
            child: SvgPicture.asset(AppImage.seeAll),
          ),
        ),
      ],
    ),
  );
}

Widget bottomBarTab(
  BuildContext context, {
  required int currentIndex,
  required int index,
  required String icon,
  required String label,
}) {
  bool isSelected = currentIndex == index;
  Color selectedColor = AppColor.themeSecondaryColor;
  Color unselectedColor = AppColor.unselectedColor;
  BottomBarCubit bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
  BlogCubit blogCubit = BlocProvider.of<BlogCubit>(context);
  PricingCubit pricingCubit = BlocProvider.of<PricingCubit>(context);

  return BlocBuilder<CategoryRadioCubit, int>(
    builder: (context, state) {
      return InkWell(
        onTap: () async {
          log('indexindex ::$index');
          if (index == 1) {
            blogCubit.getBlogs(context, search: '', isRefresh: false);
          } else if (index == 3) {
            pricingCubit.getPlans(context, categoryId: state.toString());
          }
          bottomBarCubit.changeTab(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              Gap(5),
              CustomText(
                text: label,
                fontSize: 10,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ],
          ),
        ),
      );
    },
  );
}

customCardView({
  required String image,
  double? height,
  double? width,
  required String title,
  required void Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomCachedImage(
              imageUrl: image,
              height: height,
              width: width,
            ),
          ),

          Gap(5),
          CustomText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
        ],
      ),
    ),
  );
}

customEventCardView({
  required void Function() onTap,
  required String title,
  required String imageUrl,
  required String subTitle,
  required String date,
  required String time,
  double? mainWidth,
  double? mainHeight,
  required void Function() joinNowOnTap,
  bool showButton = true,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(right: showButton == true ? 7 : 0),
      child: Container(
        width: mainWidth ?? 100.w,
        height: mainHeight ?? 30.h,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border.all(color: AppColor.themePrimaryColor2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomCachedImage(
                      width: 40.w,
                      height: 100.h,

                      imageUrl: imageUrl,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            AppImage.eventBG,
                            width: 40.w,
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: 40.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColor.whiteColor.withOpacity(0.2),
                                  AppColor.whiteColor,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                    right: 14,
                    bottom: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(6),
                      CustomText(
                        text: subTitle,
                        fontSize: 10,

                        color: AppColor.seeAllTitleColor,
                      ),
                      Gap(10),
                      customIconAndText(date: date, time: time),
                      if (showButton == true) ...[
                        Spacer(),
                        CustomButton(
                          text: 'Join Now',
                          onTap: joinNowOnTap,
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

customIconAndText({required String date, required String time}) {
  return Column(
    children: [
      Row(
        children: <Widget>[
          SvgPicture.asset(
            height: 10,
            width: 10,
            AppImage.calendar,
            color: AppColor.themeSecondaryColor,
          ),
          Gap(5),

          CustomText(text: date, fontSize: 10),
        ],
      ),
      Gap(10),
      Row(
        children: <Widget>[
          SvgPicture.asset(AppImage.clock, height: 10, width: 10),
          Gap(5),
          CustomText(text: time, fontSize: 10),
        ],
      ),
    ],
  );
}

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    log('videoUrlvideoUrl ::${widget.videoUrl}');
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl), // Play any video link passed to widget
      )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
          ],
        )
        : Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: AppColor.themePrimaryColor2,
            ),
          ),
        );
  }
}

class CustomAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const CustomAudioPlayer({super.key, required this.audioUrl});

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen for duration updates
    _player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    // Listen for position updates
    _player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    // Stop audio when it ends
    _player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  void _stop() async {
    await _player.stop();
    setState(() {
      isPlaying = false;
      _position = Duration.zero;
    });
  }

  void _seekTo(double value) {
    final position = Duration(seconds: value.toInt());
    _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 24,
                color: Colors.black87,
              ),
              onPressed: _togglePlayPause,
            ),

            Expanded(
              child: CustomText(
                text: 'Now Playing',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            CustomText(
              text: '${_formatDuration(_position)} /',
              fontSize: 12,
              color: AppColor.themeSecondaryColor,
            ),
            const SizedBox(width: 4),
            CustomText(
              text: _formatDuration(_duration),
              fontSize: 12,
              color: AppColor.themeSecondaryColor,
            ),
          ],
        ),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.5,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
          ),
          child: Slider(
            min: 0,
            max: _duration.inSeconds > 0 ? _duration.inSeconds.toDouble() : 1,
            value: _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
            activeColor: AppColor.themePrimaryColor,
            inactiveColor: AppColor.themePrimaryColor2,
            onChanged: (value) => _seekTo(value),
          ),
        ),
      ],
    );
  }
}
