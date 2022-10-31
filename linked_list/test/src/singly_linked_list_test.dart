// ignore_for_file: non_constant_identifier_names
library singly_linked_list_test;

import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';
import 'package:linked_list/linked_list.dart';

import 'matchers.dart';

void main() {
  runTestsByLibraryName('singly_linked_list_test');
}

class DummyEntry extends LinkedListEntry<DummyEntry>{}

mixin ComposedExpect{
  SinglyLinkedList<DummyEntry> get linkedList;

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

  expectFirstAndLastAreEqualTo(DummyEntry x, [DummyEntry? y]){
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(y??x));
  }

  expectFirstIsLinkedToLast(){
    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(linkedList.last));
  }

  expectLastIsLinkedToNull(){
    expect(linkedList.last?.next, isNull);
  }

  expectLinksAreCorrect(List<DummyEntry> entries){
    for(int i = 0; i < entries.length-1; i++)
      _expectCurrentIsLinkedToNext(entries[i], entries[i+1]);
    
    expect(entries.last.next, isNull);

    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(entries[1]));

    expect(linkedList.last?.next, isNull);
  }

  void _expectCurrentIsLinkedToNext(DummyEntry current, DummyEntry next) {
    expect(current.next, isNotNull);
    expect(current.next, equals(next));
  }
}

@TestCase()
@Root()
class SinglyLinkedListTest with ComposedExpect{
  @override
  late final SinglyLinkedList<DummyEntry> linkedList;
}

@TestCase()
class GivenNewlyCreatedSinglyLinkedList extends SinglyLinkedListTest{
  
  @SetUp()
  void CreateNewSinglyLinkedList() {
    linkedList = SinglyLinkedList<DummyEntry>();
  }

  @Test()
  void shouldBeEmpty(){
    expectListIsEmpty();
  }

  @Test()
  void firstAndLastShouldBeNull(){
    expectFirstAndLastAreNull();
  }

  @Test()
  void addFirst_SizeShouldBeOne(){
    linkedList.addFirst(DummyEntry());
    expectSizeIsOne();
  }

  @Test()
  void addFirst_WhenXIsAdded_ThenFirstAndLastShouldEqualToX(){
    final x = DummyEntry();
    linkedList.addFirst(x);
    expectFirstAndLastAreEqualTo(x);
  }

  @Test()
  void addLast_SizeShouldBeOne(){
    linkedList.addLast(DummyEntry());
    expectSizeIsOne();
  }

  @Test()
  void addLast_WhenXIsAdded_ThenFirstAndLastShouldEqualToX(){
    final x = DummyEntry();
    linkedList.addLast(x);
    expectFirstAndLastAreEqualTo(x);
  }

  @Test()
  void removeFirst_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeFirst();
    }

    expect(act, throwsAIllegalState);
  }

  @Test()
  void removeLast_ShouldThrowIllegalState(){
    void act(){
      linkedList.removeLast();
    }

    expect(act, throwsAIllegalState);
  }

  @Test()
  void elementAt_shouldThrowEmpty(){
    void act(){
      linkedList.elementAt(0);
    }

    expect(act, throwsAEmpty);
  }

  @Test()
  void indexOf_ShouldReturnNegativeOne(){
    expect(linkedList.indexOf(DummyEntry()), equals(-1));
  }

  @Test()
  void reverse_ThenFirstAndLastShouldBeNull(){
    linkedList.reverse();
    expectFirstAndLastAreNull();
  }
}

@TestCase()
class GivenAddingX extends GivenNewlyCreatedSinglyLinkedList{

  late final DummyEntry x;

  @SetUp()
  void addXToLinkedList() {
    x = DummyEntry();
    linkedList.addFirst(x);
  }

  @Test()
  void addFirst_SizeShouldBeTwo(){
    linkedList.addFirst(DummyEntry());
    expectSizeIsTwo();
  }

  @Test()
  void addFirst_WhenYIsAdded_ThenFirstAndLastShouldBeYAndX(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstAndLastAreEqualTo(y, x);
  }

  @Test()
  void addFirst_WhenYIsAdded_ThenFirstShouldBeLinkedToLast(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstIsLinkedToLast();
  }

  @Test()
  void addFirst_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectLastIsLinkedToNull();
  }

  @Test()
  void addLast_SizeShouldBeTwo(){
    linkedList.addLast(DummyEntry());
    expectSizeIsTwo();
  }

  @Test()
  void addLast_WhenYIsAdded_ThenFirstAndLastShouldBeXAndY(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstAndLastAreEqualTo(x, y);
  }

  @Test()
  void addLast_WhenYIsAdded_ThenFirstShouldBeLinkedToLast(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstIsLinkedToLast();
  }

  @Test()
  void addLast_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectLastIsLinkedToNull();
  }

  @Test()
  void removeFirst_ShouldBeEmpty(){
    linkedList.removeFirst();
    expectListIsEmpty();
  }

  @Test()
  void removeFirst_ThenFirstAndLastShouldBeNull(){
    linkedList.removeFirst();
    expectFirstAndLastAreNull();
  }

  @Test()
  void removeLast_ShouldBeEmpty(){
    linkedList.removeLast();
    expectListIsEmpty();
  }

  @Test()
  void removeLast_ThenFirstAndLastShouldBeNull(){
    linkedList.removeLast();
    expectFirstAndLastAreNull();
  }

  @Test()
  void elementAt_GivenNegativeIndex_ShouldThrowOutOfRange(){
    void act(){
      linkedList.elementAt(-1);
    }

    expect(act, throwsAOutOfRange);
  }

  @Test()
  void elementAt_GivenIndexGreaterThanSize_ShouldThrowOutOfRange(){
    void act(){
      linkedList.elementAt(2);
    }

    expect(act, throwsAOutOfRange);
  }

  @Test()
  void elementAt_GivenIndexEqualToSize_ShouldThrowOutOfRange(){
    void act(){
      linkedList.elementAt(1);
    }

    expect(act, throwsAOutOfRange);
  }

  @Test()
  void elementAt_Zero_ShouldReturnX(){
    expect(linkedList.elementAt(0), equals(x));
  }

  @Test()
  void indexOf_X_ShouldReturnZero(){
    expect(linkedList.indexOf(x), isZero);
  }

  @Test()
  void reverse_ThenFirstAndLastShouldBeX(){
    linkedList.reverse();
    expectFirstAndLastAreEqualTo(x);
  }
}

@TestCase()
class GivenAddingXAndY extends GivenNewlyCreatedSinglyLinkedList{

  late final DummyEntry x, y;

  @SetUp()
  void addXAndYToLinkedList() {
    x = DummyEntry();
    y = DummyEntry();

    linkedList.addFirst(x);
    linkedList.addLast(y);
  }

  @Test()
  void addFirst_WhenZIsAdded_ThenLinksShouldBeCorrect(){
    final z = DummyEntry();
    linkedList.addFirst(z);
    expectLinksAreCorrect([z, x, y]);
  }

  @Test()
  void addLast_WhenZIsAdded_ThenLinksShouldBeCorrect(){
    final z = DummyEntry();
    linkedList.addLast(z);
    expectLinksAreCorrect([x, y, z]);
  }

  @Test()
  void removeFirst_SizeShouldBeOne(){
    linkedList.removeFirst();
    expectSizeIsOne();
  }

  @Test()
  void removeFirst_FirstAndLastShouldBeEqual(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y);
  }

  @Test()
  void removeFirst_XShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expect(x.next, isNull);
  }

  @Test()
  void removeLast_SizeShouldBeOne(){
    linkedList.removeLast();
    expectSizeIsOne();
  }

  @Test()
  void removeLast_FirstAndLastShouldBeEqual(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x);
  }

  @Test()
  void removeLast_XShouldBeLinkedToNull(){
    linkedList.removeLast();
    expect(x.next, isNull);
  }

  @Test()
  void elementAt_One_ShouldReturnY(){
    expect(linkedList.elementAt(1), equals(y));
  }

  @Test()
  void indexOf_Y_shouldReturnOne(){
    expect(linkedList.indexOf(y), equals(1));
  }

  @Test()
  void reverse_ThenFirstAndLastShouldBeReversed(){
    linkedList.reverse();
    expectFirstAndLastAreEqualTo(y, x);
  }
}

@TestCase()
class GivenAddingXAndYAndZ extends GivenNewlyCreatedSinglyLinkedList{

  late final DummyEntry x, y, z;

  @SetUp()
  void addXAndYAndZToLinkedList() {
    x = DummyEntry();
    y = DummyEntry();
    z = DummyEntry();

    linkedList.addFirst(x);
    linkedList.addLast(y);
    linkedList.addLast(z);
  }

  @Test()
  void removeFirst_FirstAndLastShouldBeYAndZ(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y, z);
  }

  @Test()
  void removeLast_FirstAndLastShouldBeXAndY(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x, y);
  }

  @Test()
  void reverse_ThenYShouldBeLinkedToX(){
    linkedList.reverse();
    expect(y.next, equals(x));
  }

  @Test()
  void reverse_ThenZShouldBeLinkedToY(){
    linkedList.reverse();
    expect(z.next, equals(y));
  }

  @Test()
  void reverse_ThenLastShouldBeLinkedToNull(){
    linkedList.reverse();
    expectLastIsLinkedToNull();
  }
}




