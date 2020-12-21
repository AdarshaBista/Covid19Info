import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/hospital.dart';
import 'package:covid19_info/core/services/launcher_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid19_info/ui/widgets/common/tag.dart';

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
              await context.read<LauncherService>().launchPhone(context, hospital.phone);
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.website.isNotEmpty)
          Tag(
            label: 'Website',
            color: color,
            onPressed: () async {
              await context
                  .read<LauncherService>()
                  .launchWebsite(context, hospital.website);
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.email.isNotEmpty)
          Tag(
            label: 'Email',
            color: color,
            onPressed: () async {
              await context.read<LauncherService>().launchEmail(context, hospital.email);
            },
          ),
      ],
    );
  }
}
