// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

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

class GivenNewlyCreatedList extends BranchTestGroup{
  GivenNewlyCreatedList({required super.groups})
      : super(groupDescription: 'given newly created list');

  late SinglyLinkedList<DummyEntry> linkedList;

  @override
  void setUp() {
    linkedList = SinglyLinkedList<DummyEntry>();
  }

  void shouldBeEmpty(){
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  void firstAndLastShouldBeNull(){
    expect(linkedList.first, isNull);
    expect(linkedList.last, isNull);
  }

  void addFirst_WhenOneEntryIsAdded_ThenSizeShouldBeOne(){
    linkedList.addFirst(DummyEntry());
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void addFirst_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo(){
    linkedList.addFirst(DummyEntry());
    linkedList.addFirst(DummyEntry());
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void addLast_WhenOneEntryIsAdded_ThenSizeShouldBeOne(){
    linkedList.addLast(DummyEntry());
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void addLast_WhenTwoEntriesAreAdded_ThenSizeShouldBeTwo(){
    linkedList.addLast(DummyEntry());
    linkedList.addLast(DummyEntry());
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void removeFirst_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeFirst();
    }

    expect(act, throwsA(isA<IllegalState>()));
  }

  void removeLast_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeLast();
    }

    expect(act, throwsA(isA<IllegalState>()));
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
}

