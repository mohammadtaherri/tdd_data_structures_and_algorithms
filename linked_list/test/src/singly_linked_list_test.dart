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
              GivenAddingXAndY(),
            ],
          )
        ]);
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
      : super(groupDescription: '#1given adding x');

  late DummyEntry x;

  @override
  void setUp() {
    x = DummyEntry();
    linkedList.addFirst(x);
  }

  void addFirst_WhenYIsAdded_ThenFirstAndLastShouldBeYAndX(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstAndLastAreEqualTo(y, x);
  }

  void addFirst_WhenYIsAdded_ThenFirstShouldLinkToLast(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstIsLinkedToLast();
  }

  void addFirst_WhenYIsAdded_ThenLastShouldLinkToNull(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectLastIsLinkedToNull();
  }

  void addLast_WhenYIsAdded_ThenFirstAndLastShouldBeXAndY(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstAndLastAreEqualTo(x, y);
  }

  void addLast_WhenYIsAdded_ThenFirstShouldLinkToLast(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstIsLinkedToLast();
  }

  void addLast_WhenYIsAdded_ThenLastShouldLinkToNull(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectLastIsLinkedToNull();
  }

  void removeFirst_ShouldBeEmpty(){
    linkedList.removeFirst();
    expectListIsEmpty();
  }

  void removeFirst_ThenFirstAndLastShouldBeNull(){
    linkedList.removeFirst();
    expectFirstAndLastAreNull();
  }

  void removeLast_ShouldBeEmpty(){
    linkedList.removeLast();
    expectListIsEmpty();
  }

  void removeLast_ThenFirstAndLastShouldBeNull(){
    linkedList.removeLast();
    expectFirstAndLastAreNull();
  }

  void indexOf_X_ShouldReturnZero(){
    expect(linkedList.indexOf(x), isZero);
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll({
      'addFirst, when y is added, then first and last should be y and x': 
          Test(addFirst_WhenYIsAdded_ThenFirstAndLastShouldBeYAndX),
      
      'addFirst, when y is added, then first should link to last':
          Test(addFirst_WhenYIsAdded_ThenFirstShouldLinkToLast),

      'addFirst, when y is added, then last should link to null':
          Test(addFirst_WhenYIsAdded_ThenLastShouldLinkToNull),

      'addLast, when y is added, then first and last should be x and y': 
          Test(addLast_WhenYIsAdded_ThenFirstAndLastShouldBeXAndY),
      
      'addLast, when y is added, then first should link to last':
          Test(addLast_WhenYIsAdded_ThenFirstShouldLinkToLast),

      'addLast, when y is added, then last should link to null':
          Test(addLast_WhenYIsAdded_ThenLastShouldLinkToNull),

      'removeFirst, should be empty':
          Test(removeFirst_ShouldBeEmpty),

      'removeFirst, then first and last should be null':
          Test(removeFirst_ThenFirstAndLastShouldBeNull),

      'removeLast, should be empty':
          Test(removeLast_ShouldBeEmpty),

      'removeLast, then first and last should be null':
          Test(removeLast_ThenFirstAndLastShouldBeNull),

      'indexOf x, should return zero':
          Test(indexOf_X_ShouldReturnZero),
    });
  }
}


class GivenAddingXAndY extends LeafTestGroup with Variables, ComposedExpect{
  GivenAddingXAndY()
      : super(groupDescription: '#2given adding x and y');

  late DummyEntry x, y;

  @override
  void setUp() {
    x = DummyEntry();
    y = DummyEntry();

    linkedList.addFirst(x);
    linkedList.addLast(y);
  }

  void addFirst_WhenZIsAdded_ThenLinksShouldBeCorrect(){
    final z = DummyEntry();
    linkedList.addFirst(z);
    expectLinksAreCorrect([z, x, y]);
  }

  void addLast_WhenZIsAdded_ThenLinksShouldBeCorrect(){
    final z = DummyEntry();
    linkedList.addLast(z);
    expectLinksAreCorrect([x, y, z]);
  }

  void removeFirst_SizeShouldBeOne(){
    linkedList.removeFirst();
    expectSizeIsOne();
  }

  void removeLast_SizeShouldBeOne(){
    linkedList.removeLast();
    expectSizeIsOne();
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll({
      'addFirst, when z is added, then links should be correct':
          Test(addFirst_WhenZIsAdded_ThenLinksShouldBeCorrect),

      'addLast, when z is added, then links should be correct':
          Test(addLast_WhenZIsAdded_ThenLinksShouldBeCorrect),

      'removeFirst, size should be one': 
          Test(removeFirst_SizeShouldBeOne),

      'removeLast, size should be one': 
          Test(removeLast_SizeShouldBeOne),
    });
  }
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
    for(int i = 0; i < entries.length-1; i++){
      var current = entries[i];
      var next = entries[i+1];
      expect(current.next, isNotNull);
      expect(current.next, equals(next));
    }

    expect(entries.last.next, isNull);

    expect(linkedList.first?.next, isNotNull);
    expect(linkedList.first!.next, equals(entries[1]));

    expect(linkedList.last?.next, isNull);
  }
}