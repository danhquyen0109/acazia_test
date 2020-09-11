import 'dart:async';

import 'package:acazia_test/model/user_model.dart';
import 'package:acazia_test/utils/global.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../utils/global.dart';

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
    yield GetUserOnLoading();
    try {
      User user;
      String filePath = "lib/data/data.json";
      String content = await rootBundle.loadString(filePath);
      await Future.delayed(Duration(milliseconds: 5));
      var data = json.decode(content);
      user = User.fromJson(data["results"][0]);
      yield GetUserSuccess(user: user);
    } catch (e) {
      yield GetUserFail();
    }
    yield HomeInitial();
  }

  Stream<HomeState> _storeAsFav(User user) async* {
    yield StoreOnLoading();
    try {
      List<String> favList = storage?.getStringList("favorite_users") ?? [];
      favList.add(user.toJson().toString());
      bool isSuccess = await storage.setStringList("favorite_users", favList);
      if (isSuccess) {
        yield StoreAsFavSuccess();
      } else {
        yield StoreAsFavFail();
      }
    } catch (e) {
      yield StoreAsFavFail();
    }
    yield HomeInitial();
  }
}
