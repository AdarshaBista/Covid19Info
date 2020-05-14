import 'package:covid19_info/ui/widgets/common/tag.dart';
import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/covid_case.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

import 'package:covid19_info/ui/pages/covid_case_detail_page.dart';

class CovidCaseCard extends StatelessWidget {
  final CovidCase covidCase;
  final Color color;

  CovidCaseCard({
    @required this.covidCase,
    @required this.color,
  })  : assert(covidCase != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: GestureDetector(
        onTap: () => navigateToDetailPage(context),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(12.0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                covidCase.gender == 'male' ? LineAwesomeIcons.male : LineAwesomeIcons.female,
                color: color,
                size: 32.0,
              ),
              const SizedBox(height: 8.0),
              if (covidCase.age != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${covidCase.age.toString()} years',
                    style: AppTextStyles.smallLight,
                  ),
                ),
              Tag(
                label: 'MORE',
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDetailPage(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CovidCaseDetailPage(
          covidCase: covidCase,
          color: color,
        ),
      ),
    );
  }
}
