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
            GivenNewlyCreatedLinkedList(
              groups: [
                AddFirstMethodTest(),
              ],
            ),
          ],
        );
}

mixin LinkedListVariables on TestGroup {
  SinglyLinkedList get linkedList =>
      findVariableByKey('linked_list');
}

class GivenNewlyCreatedLinkedList extends BranchTestGroup {
  GivenNewlyCreatedLinkedList({required super.groups})
      : super(groupDescription: 'given newly created linked list');

  late SinglyLinkedList linkedList;

  @override
  void setUp() {
    linkedList = SinglyLinkedList();
  }

  void shouldBeEmpty() {
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  void firstAndLastShouldBeNull() {
    expect(linkedList.first, isNull);
    expect(linkedList.last, isNull);
  }

  @override
  void registerTests(TestContainer container) {
    container['should be empty'] = 
        Test(shouldBeEmpty);

    container['first and last should be null'] = 
        Test(firstAndLastShouldBeNull);
  }

    @override
  T? findVariableByKey<T>(String key) {
    if(key == 'linked_list')
      return linkedList as T;
      
    return super.findVariableByKey<T>(key);
  }

}


class AddFirstMethodTest extends LeafTestGroup with LinkedListVariables{
  AddFirstMethodTest(): 
      super(groupDescription: '#addFirst method ');

  @override
  void registerTests(TestContainer container) {
    
  }
}