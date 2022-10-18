// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class SinglyLinkedListTest extends RootTestGroup {
  SinglyLinkedListTest()
      : super(
          groups: [
          ],
        );

  void givenNewlyCreatedList_ShouldBeEmpty(){
    SinglyLinkedList linkedList = SinglyLinkedList();
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  @override
  void registerTests(TestContainer container) {
    container['given newly created list, should be empty'] = 
        Test(givenNewlyCreatedList_ShouldBeEmpty);
  }
}







