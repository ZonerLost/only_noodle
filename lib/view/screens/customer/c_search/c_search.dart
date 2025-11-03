import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_fonts.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';

class CSearch extends StatefulWidget {
  const CSearch({super.key});

  @override
  State<CSearch> createState() => _CSearchState();
}

class _CSearchState extends State<CSearch> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allSuggestions = [
    'Pizza',
    'Burger',
    'Sushi',
    'Pasta',
    'Salad',
    'Tacos',
    'Ice Cream',
    'Coffee',
  ];

  final List<String> _recent = ['Sushi', 'Pizza'];
  List<String> _filtered = [];
  Set<String> _trackedChars = {};

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_allSuggestions);
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _controller.text.trim().toLowerCase();
    setState(() {
      _trackedChars = q.isNotEmpty
          ? q.split('').map((s) => s.toLowerCase()).toSet()
          : <String>{};
      if (q.isEmpty) {
        _filtered = List.from(_allSuggestions);
      } else {
        _filtered = _allSuggestions
            .where((s) => s.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  TextSpan _highlightSpan(String text) {
    final tracked = _trackedChars;
    final defaultStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: kQuaternaryColor,
      fontFamily: AppFonts.Manrope,
    );
    final highlightStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: kSecondaryColor,
      fontFamily: AppFonts.Manrope,
    );

    if (tracked.isEmpty) return TextSpan(text: text, style: defaultStyle);

    final children = <TextSpan>[];
    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      if (tracked.contains(ch.toLowerCase())) {
        children.add(TextSpan(text: ch, style: highlightStyle));
      } else {
        children.add(TextSpan(text: ch, style: defaultStyle));
      }
    }
    return TextSpan(children: children);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(Assets.imagesArrowBackRounded, height: 32),
              ),
            ),
          ],
        ),
        title: SimpleTextField(hintText: 'Search...', controller: _controller),
        actions: [SizedBox(width: 20)],
      ),
      body: ListView.separated(
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _filtered.length,
        separatorBuilder: (_, __) => Container(
          height: 1,
          color: kBorderColor,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        itemBuilder: (context, index) {
          final text = _filtered[index];
          return GestureDetector(
            onTap: () {
              if (!_recent.contains(text)) {
                _recent.insert(0, text);
                if (_recent.length > 5) _recent.removeLast();
              }
              Get.back(result: text);
            },
            child: RichText(text: _highlightSpan(text)),
          );
        },
      ),
    );
  }
}
