// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

import 'matchers.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class DummyEntry extends LinkedListEntry<DummyEntry>{}

class SinglyLinkedListTest extends RootTestGroup {
  SinglyLinkedListTest()
      : super(
          groups: [
            GivenNewlyCreatedList(
              groups: [
                GivenAddingX(),
                GivenAddingXAndY(),
                GivenAddingXAndYAndZ(),
              ],
            )
          ],
        );
}

class GivenNewlyCreatedList extends BranchTestGroup with ComposedExpect{
  GivenNewlyCreatedList({required super.groups});

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

  void addFirst_SizeShouldBeOne(){
    linkedList.addFirst(DummyEntry());
    expectSizeIsOne();
  }

  void addFirst_WhenXIsAdded_ThenFirstAndLastShouldEqualToX(){
    final x = DummyEntry();
    linkedList.addFirst(x);
    expectFirstAndLastAreEqualTo(x);
  }

  void addLast_SizeShouldBeOne(){
    linkedList.addLast(DummyEntry());
    expectSizeIsOne();
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
    container.addAll([
      Test(shouldBeEmpty),
      Test(firstAndLastShouldBeNull),
      Test(addFirst_SizeShouldBeOne),
      Test(addFirst_WhenXIsAdded_ThenFirstAndLastShouldEqualToX),
      Test(addLast_SizeShouldBeOne),
      Test(addLast_WhenXIsAdded_ThenFirstAndLastShouldEqualToX),
      Test(removeFirst_ShouldThrowIllegalState),
      Test(removeLast_ShouldThrowIllegalState),
      Test(indexOf_ShouldReturnNegativeOne),
    ]);
  }

  @override
  T? findVariableByKey<T>(String key) {
    if(key == 'linked_list')
      return linkedList as T;
      
    return super.findVariableByKey<T>(key);
  }
}


class GivenAddingX extends LeafTestGroup with Variables, ComposedExpect{

  late DummyEntry x;

  @override
  void setUp() {
    x = DummyEntry();
    linkedList.addFirst(x);
  }

  void addFirst_SizeShouldBeTwo(){
    linkedList.addFirst(DummyEntry());
    expectSizeIsTwo();
  }

  void addFirst_WhenYIsAdded_ThenFirstAndLastShouldBeYAndX(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstAndLastAreEqualTo(y, x);
  }

  void addFirst_WhenYIsAdded_ThenFirstShouldBeLinkedToLast(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectFirstIsLinkedToLast();
  }

  void addFirst_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
    final y = DummyEntry();
    linkedList.addFirst(y);
    expectLastIsLinkedToNull();
  }

  void addLast_SizeShouldBeTwo(){
    linkedList.addLast(DummyEntry());
    expectSizeIsTwo();
  }

  void addLast_WhenYIsAdded_ThenFirstAndLastShouldBeXAndY(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstAndLastAreEqualTo(x, y);
  }

  void addLast_WhenYIsAdded_ThenFirstShouldBeLinkedToLast(){
    final y = DummyEntry();
    linkedList.addLast(y);
    expectFirstIsLinkedToLast();
  }

  void addLast_WhenYIsAdded_ThenLastShouldBeLinkedToNull(){
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
    container.addAll([
      Test(addFirst_SizeShouldBeTwo),
      Test(addFirst_WhenYIsAdded_ThenFirstAndLastShouldBeYAndX),
      Test(addFirst_WhenYIsAdded_ThenFirstShouldBeLinkedToLast),
      Test(addFirst_WhenYIsAdded_ThenLastShouldBeLinkedToNull),
      Test(addLast_SizeShouldBeTwo),
      Test(addLast_WhenYIsAdded_ThenFirstAndLastShouldBeXAndY),
      Test(addLast_WhenYIsAdded_ThenFirstShouldBeLinkedToLast),
      Test(addLast_WhenYIsAdded_ThenLastShouldBeLinkedToNull),
      Test(removeFirst_ShouldBeEmpty),
      Test(removeFirst_ThenFirstAndLastShouldBeNull),
      Test(removeLast_ShouldBeEmpty),
      Test(removeLast_ThenFirstAndLastShouldBeNull),
      Test(indexOf_X_ShouldReturnZero),
    ]);
  }
}


class GivenAddingXAndY extends LeafTestGroup with Variables, ComposedExpect{

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

  void removeFirst_FirstAndLastShouldBeEqual(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y);
  }

  void removeFirst_XShouldBeLinkedToNull(){
    linkedList.removeFirst();
    expect(x.next, isNull);
  }

  void removeLast_SizeShouldBeOne(){
    linkedList.removeLast();
    expectSizeIsOne();
  }

  void removeLast_FirstAndLastShouldBeEqual(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x);
  }

  void removeLast_XShouldBeLinkedToNull(){
    linkedList.removeLast();
    expect(x.next, isNull);
  }

  void indexOf_Y_shouldReturnOne(){
    expect(linkedList.indexOf(y), equals(1));
  }

  void reverse_ThenFirstAndLastShouldBeReversed(){
    linkedList.reverse();
    expectFirstAndLastAreEqualTo(y, x);
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(addFirst_WhenZIsAdded_ThenLinksShouldBeCorrect),
      Test(addLast_WhenZIsAdded_ThenLinksShouldBeCorrect),
      Test(removeFirst_SizeShouldBeOne),
      Test(removeFirst_FirstAndLastShouldBeEqual),
      Test(removeFirst_XShouldBeLinkedToNull),
      Test(removeLast_SizeShouldBeOne),
      Test(removeLast_FirstAndLastShouldBeEqual),
      Test(removeLast_XShouldBeLinkedToNull),
      Test(indexOf_Y_shouldReturnOne),
      Test(reverse_ThenFirstAndLastShouldBeReversed),
    ]);
  }
}

class GivenAddingXAndYAndZ extends LeafTestGroup with Variables, ComposedExpect{

  late DummyEntry x, y, z;

  @override
  void setUp() {
    x = DummyEntry();
    y = DummyEntry();
    z = DummyEntry();

    linkedList.addFirst(x);
    linkedList.addLast(y);
    linkedList.addLast(z);
  }

  void removeFirst_FirstAndLastShouldBeYAndZ(){
    linkedList.removeFirst();
    expectFirstAndLastAreEqualTo(y, z);
  }

  void removeLast_FirstAndLastShouldBeXAndY(){
    linkedList.removeLast();
    expectFirstAndLastAreEqualTo(x, y);
  }

  void reverse_ThenYShouldBeLinkedToX(){
    linkedList.reverse();
    expect(y.next, equals(x));
  }

  void reverse_ThenZShouldBeLinkedToY(){
    linkedList.reverse();
    expect(z.next, equals(y));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(removeFirst_FirstAndLastShouldBeYAndZ),
      Test(removeLast_FirstAndLastShouldBeXAndY),
      Test(reverse_ThenYShouldBeLinkedToX),
      Test(reverse_ThenZShouldBeLinkedToY),
    ]);
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

