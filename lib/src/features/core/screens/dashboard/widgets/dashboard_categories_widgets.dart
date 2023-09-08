import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/features/core/models/dashboard/dashboard_category_model.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final list = CategoryItemModel.list;
    return SizedBox(
      height: 45,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => SizedBox(
          width: 170,
          height: 45,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.0),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDarkMode ? secondaryColor : primaryColor,
                ),
                child: Center(
                  child: Image(image: AssetImage(list[index].categIconImage)),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(list[index].categTitle,
                        style: textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis),
                    Text(list[index].categSubTite,
                        style: textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
