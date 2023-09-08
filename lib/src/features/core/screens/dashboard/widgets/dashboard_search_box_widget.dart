import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class DashboardSearchBox extends StatelessWidget {
  const DashboardSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration:
          const BoxDecoration(border: Border(left: BorderSide(width: 4))),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(RsDashboardSearch,
              style: textTheme.displayLarge
                  ?.apply(color: Colors.grey.withOpacity(0.5))),
          const Icon(
            Icons.search_rounded,
            size: 25,
          ),
        ],
      ),
    );
  }
}
