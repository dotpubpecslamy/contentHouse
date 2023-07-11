// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/services/server.dart';

import 'views/error.dart' as error_view;
import 'views/loading.dart' as loading_view;
import 'views/main.dart' as main_view;

export 'package:provider/provider.dart';

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context) : super(loading_view.ViewState(), context: context);

  DataResponse? dataResponse;
  String? imageUrl;

  @override
  void init() async {
    dataResponse = DataResponse.fromMap(await context.server.data);

    if (dataResponse?.status_code != 200) {
      emit(error_view.ViewState());
      return;
    }

    imageUrl = dataResponse?.image;

    emit(main_view.ViewState());
  }

  Future<void> addToCount() async {
    emit(loading_view.ViewState());

    await context.server.addToCount(1);

    emit(main_view.ViewState());
  }
}

class DataResponse {
  final int status_code;
  final String? error_message;
  final String? message;
  final String? image;

  DataResponse(this.status_code, this.error_message, this.message, this.image);

  factory DataResponse.fromMap(Map<String, dynamic> map) {
    return DataResponse(
      map['status_code'],
      map['error_message'],
      map['message'],
      map['image'],
    );
  }
}
