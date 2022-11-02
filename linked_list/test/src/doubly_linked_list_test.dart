// ignore_for_file: non_constant_identifier_names
library doubly_linked_list_test;

import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';

import '../linked_list_test.dart';
import 'package:linked_list/linked_list.dart';
import 'matchers.dart';

void main() {
  runTestsByLibraryName('doubly_linked_list_test');
}


class DummyEntry extends DoublyLinkedListEntry<DummyEntry>{}

@TestCase()
@Root()
class DoublyLinkedListTest extends LinkedListTest{
  @override
  late final LinkedList<DummyEntry> linkedList;

  @override
  void expectLinksAreCorrect(covariant List<DummyEntry> entries) {
    super.expectLinksAreCorrect(entries);

    for(int i = 1; i < entries.length; i++)
      _expectCurrentIsLinkedToPrevious(entries[i], entries[i-1]);

    expect(linkedList.last!.next, isNull);
    expect(linkedList.last!.previous, equals(entries[entries.length - 2]));

    expect(linkedList.first!.next, equals(entries[1]));
    expect(linkedList.first!.previous, isNull);
  }

  void _expectCurrentIsLinkedToPrevious(DoublyLinkedListEntry current, DoublyLinkedListEntry prev) {
    expect(current.previous, isNotNull);
    expect(current.previous, equals(prev));
  }

  @override
  void expectFirstIsLinkedTo(covariant DummyEntry? next, [covariant DummyEntry? previous]){
    super.expectFirstIsLinkedTo(next);
    expect(linkedList.first!.previous, equals(previous));
  }

  @override
  void expectLastIsLinkedTo(covariant DummyEntry? next, [covariant DummyEntry? previous]){
    super.expectLastIsLinkedTo(next);
    expect(linkedList.last!.previous, equals(previous));
  }
}

@TestCase()
class GivenNewlyCreatedDoublyLinkedList extends DoublyLinkedListTest{
  
  @SetUp()
  void createNewDoublyLinkedList() {
    linkedList = DoublyLinkedList<DummyEntry>();
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
  void addFirst_WhenXIsAdded_ThenFirstAndLastShouldBeLinkedToNull(){
    final x = DummyEntry();
    linkedList.addFirst(x);
    expectFirstIsLinkedTo(null, null);
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
  void addLast_WhenXIsAdded_ThenFirstAndLastShouldBeLinkedToNull(){
    final x = DummyEntry();
    linkedList.addLast(x);
    expectFirstIsLinkedTo(null, null);
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
class GivenAddingX extends GivenNewlyCreatedDoublyLinkedList{

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
  void addFirst_WhenYIsAdded_ThenFirstShouldBeLinkedToLastAndNull(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstIsLinkedTo(linkedList.last, null);
  }

  @Test()
  void addFirst_WhenYIsAdded_ThenLastShouldBeLinkedToNullAndFirst(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectLastIsLinkedTo(null, linkedList.first);
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
  void addLast_WhenYIsAdded_ThenFirstShouldBeLinkedToLastAndNull(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstIsLinkedTo(linkedList.last, null);
  }

  @Test()
  void addLast_WhenYIsAdded_ThenLastShouldBeLinkedToNullAndFirst(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectLastIsLinkedTo(null, linkedList.first);
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
class GivenAddingXAndY extends GivenNewlyCreatedDoublyLinkedList{

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
  void removeFirst_FirstAndLastShouldBeEqualToY(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y);
  }

  @Test()
  void removeFirst_ThenXShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expect(x.next, isNull);
    expect(x.previous, isNull);
  }

  @Test()
  void removeFirst_ThenFirstAndLastShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expectLastIsLinkedTo(null, null);
  }

  @Test()
  void removeLast_SizeShouldBeOne(){
    linkedList.removeLast();
    expectSizeIsOne();
  }

  @Test()
  void removeLast_FirstAndLastShouldBeEqualToX(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x);
  }

  @Test()
  void removeLast_ThenYShouldBeLinkedToNull(){
    linkedList.removeLast();
    expect(y.next, isNull);
    expect(y.previous, isNull);
  }

  @Test()
  void removeLast_ThenFirstAndLastShouldBeLinkedToNull(){
    linkedList.removeLast();
    expectLastIsLinkedTo(null, null);
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
  void reverse_ThenYNextShouldBeX(){
    linkedList.reverse();
    expect(y.next, equals(x));
  }

  @Test()
  void reverse_ThenXPreviousShouldBeY(){
    linkedList.reverse();
    expect(x.previous, equals(y));
  }

  @Test()
  void reverse_ThenFirstAndLastShouldBeReversed(){
    linkedList.reverse();
    expectFirstAndLastAreEqualTo(y, x);
  }

  @Test()
  void reverse_ThenFirstPreviousShouldBeNull(){
    linkedList.reverse();
    expect(linkedList.first!.previous, isNull);
  }

  @Test()
  void reverse_ThenLastNextShouldBeNull(){
    linkedList.reverse();
    expect(linkedList.last!.next, isNull);
  }
}

@TestCase()
class GivenAddingXAndYAndZ extends GivenNewlyCreatedDoublyLinkedList{

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
  void removeFirst_ThenLinksShouldBeCorrect(){
    linkedList.removeFirst();
    expectLinksAreCorrect([y, z]);
  }

  @Test()
  void removeLast_ThenLinksShouldBeCorrect(){
    linkedList.removeLast();
    expectLinksAreCorrect([x, y]);
  }

  @Test()
  void reverse_ThenZNextShouldBeY(){
    linkedList.reverse();
    expect(z.next, equals(y));
  }

  @Test()
  void reverse_ThenYPreviousShouldBeZ(){
    linkedList.reverse();
    expect(y.previous, equals(z));
  }
}




