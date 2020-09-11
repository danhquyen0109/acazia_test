part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetUser extends HomeEvent {}

class StoreAsFav extends HomeEvent {
  final User user;
  StoreAsFav({@required this.user});
}
