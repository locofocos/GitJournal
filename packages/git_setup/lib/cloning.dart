/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:gitjournal/generated/locale_keys.g.dart';

import 'error.dart';
import 'git_transfer_progress.dart';
import 'loading.dart';

class GitHostCloningPage extends StatelessWidget {
  final String? errorMessage;
  final String loadingMessage;
  final GitTransferProgress cloneProgress;

  GitHostCloningPage({
    required this.errorMessage,
    required this.cloneProgress,
    super.key,
  }) : loadingMessage = tr(LocaleKeys.setup_cloning);

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return GitHostSetupErrorPage(errorMessage!);
    }

    var stats = cloneProgress;
    if (stats.totalObjects == 0) {
      return GitHostSetupLoadingPage(loadingMessage);
    }

    var text = '${cloneProgress.networkText}\n${cloneProgress.indexText}';

    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          loadingMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          value: null,
        ),
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
