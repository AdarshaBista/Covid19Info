import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/widgets/common/tag.dart';
import 'package:covid19_info/ui/widgets/common/ui_helper.dart';

class ActionRow extends StatelessWidget {
  final Hospital hospital;
  final Color color;

  const ActionRow({
    @required this.hospital,
    @required this.color,
  })  : assert(hospital != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (hospital.phone.isNotEmpty)
          Tag(
            label: 'Call',
            color: color,
            onPressed: () async {
              String phoneNumber = hospital.phone.split(',').first;
              if (await canLaunch('tel:$phoneNumber')) {
                await launch('tel:$phoneNumber');
              } else {
                UiHelper.showMessage(context, 'Cannot open phone!');
              }
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.website.isNotEmpty)
          Tag(
            label: 'Website',
            color: color,
            onPressed: () async {
              final url = hospital.website.contains('http')
                  ? hospital.website
                  : 'http:${hospital.website}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                UiHelper.showMessage(context, 'Cannot open website!');
              }
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.email.isNotEmpty)
          Tag(
            label: 'Email',
            color: color,
            onPressed: () async {
              String emailAddress = 'mailto:${hospital.email}';
              if (await canLaunch(emailAddress)) {
                await launch(emailAddress);
              } else {
                UiHelper.showMessage(context, 'Cannot open email!');
              }
            },
          ),
      ],
    );
  }
}
