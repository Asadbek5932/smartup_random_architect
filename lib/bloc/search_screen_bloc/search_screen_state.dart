import 'package:dev_kit/window/page_bloc.dart';

class SearchScreenState extends PageState {
  final List<String> filteredList;
  SearchScreenState({this.filteredList = const []});

  SearchScreenState copyWith(List<String>? filteredList) {
    return SearchScreenState(filteredList: filteredList ?? this.filteredList);
  }

}