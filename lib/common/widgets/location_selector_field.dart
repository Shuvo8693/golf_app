import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/app/data/google_api_service.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

class LocationSelector extends StatefulWidget {
  final ValueChanged<String> onSelected;

  const LocationSelector({Key? key, required this.onSelected}) : super(key: key);

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final TextEditingController _searchController = TextEditingController();
  List<String> suggestions = [];

  Future<void> _fetchSuggestions(String query) async {
    if (query.isNotEmpty) {
      try {
        final result = await GoogleApiService.fetchSuggestions(query);
        setState(() {
          suggestions = result;
        });
      } catch (e) {
        print("Error fetching suggestions: $e");
      }
    } else {
      setState(() {
        suggestions.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            onChanged: _fetchSuggestions,
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppString.searchLocationText,
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 24.h,
              ),
            ),
            onSubmitted: (value) {
              widget.onSelected(value);
              print('On Submitted: $value');
            },
          ),
           SizedBox(height: 8.h),
          if (suggestions.isNotEmpty)
            Padding(
              padding:  EdgeInsets.only(left: 8.0.w),
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                      color: AppColors.gray.withOpacity(0.7),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.location_pin),
                      onTap: () {
                        widget.onSelected(suggestions[index]);
                        _searchController.text = suggestions[index];
                        setState(() {
                          suggestions.clear();
                        });

                      },
                      title: Text(suggestions[index],style: AppStyles.h4(),),
                    );
                  },
                ),
              ),
            ),

        ],
      ),
    );
  }
}