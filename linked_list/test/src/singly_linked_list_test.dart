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

class IntEntry extends LinkedListEntry{
}

class GivenNewlyCreatedLinkedList extends BranchTestGroup {
  GivenNewlyCreatedLinkedList({required super.groups})
      : super(groupDescription: 'given newly created linked list');

  late SinglyLinkedList<IntEntry> linkedList;

  @override
  void setUp() {
    linkedList = SinglyLinkedList<IntEntry>();
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

  void whenOneItemIsAdded_ThenSizeShouldBeOne(){
    IntEntry entry = IntEntry();
    linkedList.addFirst(entry);
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenTwoItemsAreAdded_ThenSizeShouldBeTwo(){
    IntEntry entry = IntEntry();
    linkedList.addFirst(entry);
    linkedList.addFirst(entry);
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenXIsAdded_ThenFirstAndLastShouldBeX(){
    final x = IntEntry();
    linkedList.addFirst(x);
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(x));
  }

  void whenXAndYAreAdded_ThenFirstAndLastShouldBeYAndX(){
    final x = IntEntry();
    final y = IntEntry();
    linkedList.addFirst(x);
    linkedList.addFirst(y);
    expect(linkedList.first, equals(y));
    expect(linkedList.last, equals(x));
  }

  @override
  void registerTests(TestContainer container) {
    container['when one item is added, then size should be one'] = 
        Test(whenOneItemIsAdded_ThenSizeShouldBeOne);

    container['when two items are added, then size should be two'] = 
        Test(whenTwoItemsAreAdded_ThenSizeShouldBeTwo);

    container['when x is added, then first and last should be x'] =
        Test(whenXIsAdded_ThenFirstAndLastShouldBeX);

    container['when x and y are added, the first and last should be y and x'] = 
        Test(whenXAndYAreAdded_ThenFirstAndLastShouldBeYAndX);
  }
}

