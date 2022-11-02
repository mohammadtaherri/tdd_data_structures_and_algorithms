// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';

import 'package:linked_list_composition/linked_list.dart';

import '../linked_list_test.dart';
import 'matchers.dart';

void main() {
  runTestsByLibraryName('singly_linked_list_test');
}

class DummyEntry extends LinkedListEntry<DummyEntry>{}

@TestCase()
@Root()
class SinglyLinkedListTest extends LinkedListTest{
  @override
  late final LinkedList<DummyEntry> linkedList;

  @override
  void expectLinksAreCorrect(covariant List<DummyEntry> entries) {
    super.expectLinksAreCorrect(entries);

    expectLastIsLinkedTo(null);
    expectFirstIsLinkedTo(entries[1]);
  }
}

@TestCase()
class GivenNewlyCreatedSinglyLinkedList extends SinglyLinkedListTest{
  
  @SetUp()
  void createNewSinglyLinkedList() {
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
  void addFirst_WhenXIsAdded_ThenFirstAndLastShouldBeLinkedToNull(){
    final x = DummyEntry();
    linkedList.addFirst(x);
    expectFirstIsLinkedTo(null);
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
    expectFirstIsLinkedTo(null);
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
    expectFirstIsLinkedTo(linkedList.last);
  }

  @Test()
  void addFirst_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectLastIsLinkedTo(null);
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
    expectFirstIsLinkedTo(linkedList.last);
  }

  @Test()
  void addLast_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectLastIsLinkedTo(null);
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
  void removeFirst_FirstAndLastShouldBeEqualToY(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y);
  }

  @Test()
  void removeFirst_XShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expect(x.next, isNull);
  }

  @Test()
  void removeFirst_ThenFirstAndLastShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expectFirstIsLinkedTo(null);
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
  void removeLast_ThenFirstAndLastShouldBeLinkedToNull(){
    linkedList.removeLast();
    expectFirstIsLinkedTo(null);
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
  void reverse_ThenYShouldBeLinkedToX(){
    linkedList.reverse();
    expect(y.next, equals(x));
  }

  @Test()
  void reverse_ThenFirstAndLastShouldBeReversed(){
    linkedList.reverse();
    expectFirstAndLastAreEqualTo(y, x);
  }

  @Test()
  void reverse_ThenLastShouldBeLinkedToNull(){
    linkedList.reverse();
    expectLastIsLinkedTo(null);
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
  void removeFirst_ThenFirstAndLastShouldBeYAndZ(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y, z);
  }

  @Test()
  void removeFirst_ThenLinksShouldBeCorrect(){
    linkedList.removeFirst();
    expectLinksAreCorrect([y, z]);
  }

  @Test()
  void removeLast_ThenFirstAndLastShouldBeXAndY(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x, y);
  }

  @Test()
  void removeLast_ThenLinksShouldBeCorrect(){
    linkedList.removeLast();
    expectLinksAreCorrect([x, y]);
  }

  @Test()
  void reverse_ThenZShouldBeLinkedToY(){
    linkedList.reverse();
    expect(z.next, equals(y));
  }
}
