import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';

import 'package:linked_list/linked_list.dart';


void main() {
  runTestsByLibraryPath('src/singly_linked_list_test.dart');
  runTestsByLibraryPath('src/circular_linked_list_test.dart');
}


abstract class LinkedListTest with ComposedExpect{}

class DummyEntry extends LinkedListEntry<DummyEntry>{}

mixin ComposedExpect{
  LinkedList<DummyEntry> get linkedList;

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