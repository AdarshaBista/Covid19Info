import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/covid_case.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/tag.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

import 'package:covid19_info/ui/pages/covid_case_details_page.dart';

class CovidCaseCard extends StatelessWidget {
  final Color color;
  final CovidCase covidCase;

  const CovidCaseCard({
    @required this.color,
    @required this.covidCase,
  })  : assert(color != null),
        assert(covidCase != null);

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
                covidCase.gender == 'male'
                    ? LineAwesomeIcons.male
                    : covidCase.gender == 'female'
                        ? LineAwesomeIcons.female
                        : LineAwesomeIcons.dot_circle_o,
                color: color,
                size: 32.0,
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '${covidCase.age != null ? covidCase.age.toString() : 'N/A'} years',
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

  void navigateToDetailPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CovidCaseDetailsPage(
          covidCase: covidCase,
          color: color,
        ),
      ),
    );
  }
}
