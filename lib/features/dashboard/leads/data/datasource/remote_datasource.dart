import 'dart:developer';

import 'package:cars_right/core/utils/urls.dart';
import 'package:cars_right/features/login/presentation/logic/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DashBoardRemoteDatasource {
  Future<String> getAvailableLeads(String uName);
}

class DashboardRemoteDatasourceImpl extends DashBoardRemoteDatasource {
  final Ref ref;
  DashboardRemoteDatasourceImpl(this.ref);

  @override
  Future<String> getAvailableLeads(String uName) async {
    try {
      final url = '${Url.availableLeads}/$uName';
      final body = await ref.read(apiService).get(url);
      log('Response from GET API: $body');
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
