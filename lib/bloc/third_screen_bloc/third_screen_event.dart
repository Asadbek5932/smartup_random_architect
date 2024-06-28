import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_bloc.dart';

import '../../models/team.dart';

class ThirdScreenEvent extends PageEvent {}

class ThirdScreenRemoveUserEvent extends ThirdScreenEvent {
  Team team;

  ThirdScreenRemoveUserEvent({required this.team});
}

class ThirdScreenAddNewUserEvent extends ThirdScreenEvent {
  Team team;

  ThirdScreenAddNewUserEvent({required this.team});
}

class ThirdScreenUpdateUserEvent extends ThirdScreenEvent {
  Team team;

  ThirdScreenUpdateUserEvent({required this.team});
}

class ThirdScreenLoadDataEvent extends ThirdScreenEvent {
  BuildContext context;
  ThirdScreenLoadDataEvent({required this.context});
}

class ThirdScreenClearEverythingEvent extends ThirdScreenEvent {
}

class ThirdScreenGenerateGroupsEvent extends ThirdScreenEvent {
  BuildContext context;
  ThirdScreenBloc bloc;
  ThirdScreenGenerateGroupsEvent({required this.context, required this.bloc});
}
