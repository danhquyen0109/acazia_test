part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserSuccess extends HomeState {
  final User user;

  GetUserSuccess({@required this.user});
}

class GetUserFail extends HomeState {}

class StoreAsFavSuccess extends HomeState {}

class StoreAsFavFail extends HomeState {}
