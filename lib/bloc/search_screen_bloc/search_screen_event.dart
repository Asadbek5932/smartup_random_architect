import 'package:dev_kit/window/page_bloc.dart';

class SearchScreenEvent extends PageEvent {}

class SearchScreenEditTextEvent extends SearchScreenEvent {}

class SearchSreenInitilizeFilteredListEvent extends SearchScreenEvent {
  List<String> filteredList;
  SearchSreenInitilizeFilteredListEvent({this.filteredList = const []});
}

class SearchScreenRemoveItemEvent extends SearchScreenEvent {
  final String word;
  SearchScreenRemoveItemEvent({required this.word});
}

