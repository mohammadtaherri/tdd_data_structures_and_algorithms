// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

import 'matchers.dart';
import 'singly_linked_list_old_test.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class DummyEntry extends LinkedListEntry{}

class SinglyLinkedListTest extends RootTestGroup {
  SinglyLinkedListTest()
      : super(groups: [
          GivenNewlyCreatedList(
            groups: [],
          )
        ]);
}

mixin Variables on TestGroup {
  SinglyLinkedList get linkedList => findVariableByKey('linked_list');
}

mixin UtilityMethods on TestGroup{
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
}


class GivenNewlyCreatedList extends BranchTestGroup with UtilityMethods{
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

  void addLast_WhenOneEntryIsAdded_ThenSizeShouldBeOne(){
    linkedList.addLast(DummyEntry());
    expectSizeIsOne();
  }

  void addLast_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo(){
    linkedList.addLast(DummyEntry());
    linkedList.addLast(DummyEntry());
    expectSizeIsTwo();
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

  @override
  void registerTests(TestContainer container) {
    container['should be empty'] = 
        Test(shouldBeEmpty);

    container['first and last should be null'] = 
        Test(firstAndLastShouldBeNull);

    container['addFirst, when one entry is added, then size should be one'] = 
        Test(addFirst_WhenOneEntryIsAdded_ThenSizeShouldBeOne);

    container['addFirst, when two entries are added, then size should be two'] = 
        Test(addFirst_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo);

    container['addLast, when one entry is added, then size should be one'] = 
        Test(addLast_WhenOneEntryIsAdded_ThenSizeShouldBeOne);

    container['addLast, when two entries are added, then size should be two'] = 
        Test(addLast_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo);

    container['removeFirst, should throw IllegalState'] = 
        Test(removeFirst_ShouldThrowIllegalState);

    container['removeLast, should throw IllegalState'] = 
        Test(removeLast_ShouldThrowIllegalState);
  }

  @override
  T? findVariableByKey<T>(String key) {
    if(key == 'linked_list')
      return linkedList as T;
      
    return super.findVariableByKey<T>(key);
  }
}

