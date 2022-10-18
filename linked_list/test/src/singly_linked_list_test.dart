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
                AddLastMethodTest(),
              ],
            ),
          ],
        );
}



mixin LinkedListVariables on TestGroup {
  SinglyLinkedList get linkedList =>
      findVariableByKey('linked_list');

  IntEntry get x => findVariableByKey('x');
  IntEntry get y => findVariableByKey('y');
  IntEntry get z => findVariableByKey('z');
}

class IntEntry extends LinkedListEntry<IntEntry>{}

class GivenNewlyCreatedLinkedList extends BranchTestGroup {
  GivenNewlyCreatedLinkedList({required super.groups})
      : super(groupDescription: 'given newly created linked list');

  late SinglyLinkedList<IntEntry> linkedList;
  late IntEntry x, y, z;

  @override
  void setUp() {
    linkedList = SinglyLinkedList<IntEntry>();

    x = IntEntry();
    y = IntEntry();
    z = IntEntry();
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

    if(key == 'x')
      return x as T;

    if(key == 'y')
      return y as T;

    if(key == 'z')
      return z as T;
      
    return super.findVariableByKey<T>(key);
  }

}


class AddFirstMethodTest extends LeafTestGroup with LinkedListVariables{
  AddFirstMethodTest(): 
      super(groupDescription: '#addFirst method ');

  void whenOneItemIsAdded_ThenSizeShouldBeOne(){
    _addEntries([x]);
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenTwoItemsAreAdded_ThenSizeShouldBeTwo(){
    _addEntries([x, y]);
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenXIsAdded_ThenFirstAndLastShouldBeX(){
    _addEntries([x]);
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(x));
  }

  void whenXAndYAreAdded_ThenFirstAndLastShouldBeYAndX(){
    _addEntries([x, y]);
    expect(linkedList.first, equals(y));
    expect(linkedList.last, equals(x));
  }

  void whenTwoItemsAreAdded_ThenFirstShouldLinkToLast(){
    _addEntries([x, y]);
    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(linkedList.last));
  }

  void whenTwoItemsAreAdded_ThenLastShouldLinkToNull(){
    _addEntries([x, y]);
    expect(linkedList.last?.next, isNull);
  }

  void whenThreeItemsAreAdded_ThenLinksShouldBeCorrect(){
    _addEntries([x, y, z]);

    expect(z.next, isNotNull);
    expect(z.next, equals(y));

    expect(y.next, isNotNull);
    expect(y.next, equals(x));

    expect(x.next, isNull);

    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(y));

    expect(linkedList.last?.next, isNull);
  }

   void _addEntries(List<IntEntry> entries){
    for(var entry in entries)
      linkedList.addFirst(entry);
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

    container['when two items are added, then first should link to last'] = 
        Test(whenTwoItemsAreAdded_ThenFirstShouldLinkToLast);

    container['when two items are added, then last should link to null'] = 
        Test(whenTwoItemsAreAdded_ThenLastShouldLinkToNull);

    container['when three items are added, then links should be correct'] = 
        Test(whenThreeItemsAreAdded_ThenLinksShouldBeCorrect);
  }
}


class AddLastMethodTest extends LeafTestGroup with LinkedListVariables{
  AddLastMethodTest()
      : super(groupDescription: '#addLast method ');

  void whenOneItemIsAdded_ThenSizeShouldBeOne(){
    _addEntries([x]);
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenTwoItemsAreAdded_ThenSizeShouldBeTwo(){
    _addEntries([x, y]);
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void whenXIsAdded_ThenFirstAndLastShouldBeX(){
    _addEntries([x]);
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(x));
  }

  void whenXAndYAreAdded_ThenFirstAndLastShouldBeXAndY(){
    _addEntries([x, y]);
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(y));
  }

  void whenTwoItemsAreAdded_ThenFirstShouldLinkToLast(){
    _addEntries([x, y]);
    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(linkedList.last));
  }

  void whenTwoItemsAreAdded_ThenLastShouldLinkToNull(){
    _addEntries([x, y]);
    expect(linkedList.last?.next, isNull);
  }

   void whenThreeItemsAreAdded_ThenLinksShouldBeCorrect(){
    _addEntries([x, y, z]);

    expect(x.next, isNotNull);
    expect(x.next, equals(y));

    expect(y.next, isNotNull);
    expect(y.next, equals(z));

    expect(z.next, isNull);

    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(y));

    expect(linkedList.last?.next, isNull);
  }

  void _addEntries(List<IntEntry> entries){
    for(var entry in entries)
      linkedList.addLast(entry);
  }

  @override
  void registerTests(TestContainer container) {
    container['when one item is added, then size should be one'] = 
        Test(whenOneItemIsAdded_ThenSizeShouldBeOne);

    container['when two items are added, then size should be two'] = 
        Test(whenTwoItemsAreAdded_ThenSizeShouldBeTwo);

    container['when x is added, then first and last should be x'] =
        Test(whenXIsAdded_ThenFirstAndLastShouldBeX);

    container['when x and y are added, then first and last should be x and y'] = 
        Test(whenXAndYAreAdded_ThenFirstAndLastShouldBeXAndY);

    container['when two items are added, then first should link to last'] = 
        Test(whenTwoItemsAreAdded_ThenFirstShouldLinkToLast);

    container['when two items are added, then last should link to null'] = 
        Test(whenTwoItemsAreAdded_ThenLastShouldLinkToNull);

    container['when three items are added, then links should be correct'] = 
        Test(whenThreeItemsAreAdded_ThenLinksShouldBeCorrect);
  }
}
