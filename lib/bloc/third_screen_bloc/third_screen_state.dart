import 'package:dev_kit/window/page_bloc.dart';
import 'package:smartup_random_architect/models/team.dart';

class ThirdScreenState extends PageState{}

class ThirdScreenInitialState extends PageState {
  final List<Team> listOfUsers;

  ThirdScreenInitialState({required this.listOfUsers});

  ThirdScreenInitialState copyWith({
    List<Team>? listOfUsers,
  }) {
    return ThirdScreenInitialState(
      listOfUsers: listOfUsers ?? this.listOfUsers,
    );
  }

  @override
  List<Object> get props => [listOfUsers];
}
