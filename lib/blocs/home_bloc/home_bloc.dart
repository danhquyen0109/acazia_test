import 'dart:async';

import 'package:acazia_test/model/user_model.dart';
import 'package:acazia_test/utils/global.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'dart:convert';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetUser) {
      yield* _getUser();
    } else if (event is StoreAsFav) {
      yield* _storeAsFav(event.user);
    }
  }

  Stream<HomeState> _getUser() async* {
    User user;
    String filePath = "lib/data/data.json";
    String content = await rootBundle.loadString(filePath);
    var data = json.decode(content);
    user = User.fromJson(data["results"][0]);
    yield GetUserSuccess(user: user);
    yield HomeInitial();
  }

  Stream<HomeState> _storeAsFav(User user) async* {
    bool isSuccess =
        await storage.setString("favorite_user", user.toJson().toString());
    if (isSuccess) {
      yield StoreAsFavSuccess();
    } else {
      yield StoreAsFavFail();
    }
    yield HomeInitial();
  }
}
