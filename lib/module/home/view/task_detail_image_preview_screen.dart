import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';

class TaskDetailImagePreviewScreen extends StatefulWidget {
  final dynamic argument;

  const TaskDetailImagePreviewScreen({super.key, this.argument});

  @override
  _TaskDetailImagePreviewScreenState createState() =>
      _TaskDetailImagePreviewScreenState();
}

class _TaskDetailImagePreviewScreenState
    extends State<TaskDetailImagePreviewScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.argument['initialIndex'];
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    if (_currentIndex < widget.argument['images'].length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List images = widget.argument['images'];
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: '',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: InteractiveViewer(
                        panEnabled: true,
                        scaleEnabled: true,
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.network(
                          images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.themePrimaryColor,
              ),
              onPressed: _previousImage,
            ),
          ),
          Positioned(
            right: 16,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.themePrimaryColor,
              ),
              onPressed: _nextImage,
            ),
          ),
        ],
      ),
    );
  }
}
