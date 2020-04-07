import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const SearchBox({
    this.onChanged,
    this.hintText = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        onChanged: onChanged,
        maxLines: 1,
        style: AppTextStyles.smallLight,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Hospitals',
          prefixIcon: Icon(
            Icons.search,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
