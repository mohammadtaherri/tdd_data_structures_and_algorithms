import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class SinglyLinkedListTest extends RootTestGroup{
  SinglyLinkedListTest()
      : super(
        groups: [

        ]
      );
}

class GivenNewlyCreatedList extends BranchTestGroup{
  GivenNewlyCreatedList({required super.groups})
      : super(groupDescription: 'given newly created list');
}