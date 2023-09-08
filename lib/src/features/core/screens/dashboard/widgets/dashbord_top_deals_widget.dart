import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/models/dashboard/dashboard_deals_card_model.dart';

class DashboardTopDeals extends StatelessWidget {
  const DashboardTopDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final list = TopDealsCardModel.list;
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              SizedBox(
                width: 320,
                height: 170,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(RsDashboardCardPadding + 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkMode ? RsCardBgDarkColor : RsCardBgLightColor,
                    image: DecorationImage(
                        image: AssetImage(list[index].dealsBgImage),
                        fit: BoxFit.cover,
                        opacity: 0.8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          list[index].dealsTitle.toUpperCase(),
                          style: textTheme.displayLarge?.apply(shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 15,
                              color: isDarkMode
                                  ? primaryColor.withOpacity(0.8)
                                  : secondaryColor.withOpacity(0.8),
                            )
                          ]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          list[index].dealsSubTitle,
                          style: textTheme.headlineMedium?.apply(shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              color: isDarkMode
                                  ? primaryColor.withOpacity(0.8)
                                  : secondaryColor.withOpacity(0.8),
                            )
                          ]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: RsDashboardCardPadding),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: list[index].onPress,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(2)),
                          child: Text("SUBSCRIBE"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
