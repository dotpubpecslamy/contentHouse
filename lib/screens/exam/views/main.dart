import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;
import 'package:mobile_exam/core/services/server.dart';

import '../bloc.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Image.network(
            context.bloc.imageUrl!,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              return Image.asset('assets/images/flutter_logo.png');
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/flutter_logo.png',
                color: Colors.red,
              );
            },
          ),
          const SizedBox(height: 20),
          Text(context.strings.examDescription, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.bloc.addToCount();
            },
            child: Text('Counter ${context.server.count.toString()}'),
          )
        ],
      ),
    );
  }
}
