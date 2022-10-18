// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

import 'matchers.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class DummyEntry extends LinkedListEntry{}

class SinglyLinkedListTest extends RootTestGroup {
  SinglyLinkedListTest()
      : super(groups: [
          GivenNewlyCreatedList(
            groups: [
              GivenAddingX(),
            ],
          )
        ]);
}

mixin Variables on TestGroup {
  SinglyLinkedList get linkedList => findVariableByKey('linked_list');
}

mixin ComposedExpect on TestGroup{
  SinglyLinkedList get linkedList => findVariableByKey('linked_list');

  expectListIsEmpty(){
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  expectSizeIsOne(){
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  expectSizeIsTwo(){
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  expectFirstAndLastAreNull(){
    expect(linkedList.first, isNull);
    expect(linkedList.last, isNull);
  }

  expectFirstAndLastAreEqualTo(DummyEntry x){
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(x));
    expect(linkedList.last, equals(linkedList.first));
  }
}


class GivenNewlyCreatedList extends BranchTestGroup with ComposedExpect{
  GivenNewlyCreatedList({required super.groups})
      : super(groupDescription: 'given newly created list');

  @override
  late SinglyLinkedList<DummyEntry> linkedList;

  @override
  void setUp() {
    linkedList = SinglyLinkedList<DummyEntry>();
  }

  void shouldBeEmpty(){
    expectListIsEmpty();
  }

  void firstAndLastShouldBeNull(){
    expectFirstAndLastAreNull();
  }

  void addFirst_WhenOneEntryIsAdded_ThenSizeShouldBeOne(){
    linkedList.addFirst(DummyEntry());
    expectSizeIsOne();
  }

  void addFirst_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo(){
    linkedList.addFirst(DummyEntry());
    linkedList.addFirst(DummyEntry());
    expectSizeIsTwo();
  }

  void addFirst_WhenXIsAdded_ThenFirstAndLastShouldEqualToX(){
    final x = DummyEntry();
    linkedList.addFirst(x);
    expectFirstAndLastAreEqualTo(x);
  }

  void addLast_WhenOneEntryIsAdded_ThenSizeShouldBeOne(){
    linkedList.addLast(DummyEntry());
    expectSizeIsOne();
  }

  void addLast_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo(){
    linkedList.addLast(DummyEntry());
    linkedList.addLast(DummyEntry());
    expectSizeIsTwo();
  }

  void addLast_WhenXIsAdded_ThenFirstAndLastShouldEqualToX(){
    final x = DummyEntry();
    linkedList.addLast(x);
    expectFirstAndLastAreEqualTo(x);
  }

  void removeFirst_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeFirst();
    }

    expect(act, throwsAIllegalState);
  }

  void removeLast_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeLast();
    }

    expect(act, throwsAIllegalState);
  }

  void indexOf_ShouldReturnNegativeOne(){
    expect(linkedList.indexOf(DummyEntry()), equals(-1));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll({
      'should be empty': 
          Test(shouldBeEmpty),

      'first and last should be null': 
          Test(firstAndLastShouldBeNull),

      'addFirst, when one entry is added, then size should be one':
          Test(addFirst_WhenOneEntryIsAdded_ThenSizeShouldBeOne),

      'addFirst, when two entries are added, then size should be two':
          Test(addFirst_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo),

      'addFirst, when x is added, then first ans last should equal to x':
          Test(addFirst_WhenXIsAdded_ThenFirstAndLastShouldEqualToX),

      'addLast, when one entry is added, then size should be one':
          Test(addLast_WhenOneEntryIsAdded_ThenSizeShouldBeOne),

      'addLast, when two entries are added, then size should be two':
          Test(addLast_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo),

      'addLast, when x is added, then first ans last should equal to x':
          Test(addLast_WhenXIsAdded_ThenFirstAndLastShouldEqualToX),

      'removeFirst, should throw IllegalState':
          Test(removeFirst_ShouldThrowIllegalState),

      'removeLast, should throw IllegalState':
          Test(removeLast_ShouldThrowIllegalState),

      'indexOf, should return negative one':
          Test(indexOf_ShouldReturnNegativeOne),
    });
  }

  @override
  T? findVariableByKey<T>(String key) {
    if(key == 'linked_list')
      return linkedList as T;
      
    return super.findVariableByKey<T>(key);
  }
}


class GivenAddingX extends LeafTestGroup with Variables, ComposedExpect{
  GivenAddingX()
      : super(groupDescription: 'given adding x');

  late DummyEntry x;

  @override
  void setUp() {
    x = DummyEntry();
    linkedList.addFirst(x);
  }

  @override
  void registerTests(TestContainer container) {
    
  }
}

