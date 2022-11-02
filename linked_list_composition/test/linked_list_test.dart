import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';

import 'package:linked_list_composition/linked_list.dart';

void main() {
  runTestsByLibraryPath('src/singly_linked_list_test.dart');
}


abstract class LinkedListTest with ComposedExpect{}

mixin ComposedExpect{
  LinkedList<LinkedListEntry> get linkedList;

  void expectListIsEmpty(){
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  void expectSizeIsOne(){
    expect(linkedList.size, equals(1));
    expect(linkedList.isEmpty, isFalse);
  }

  void expectSizeIsTwo(){
    expect(linkedList.size, equals(2));
    expect(linkedList.isEmpty, isFalse);
  }

  void expectFirstAndLastAreNull(){
    expect(linkedList.first, isNull);
    expect(linkedList.last, isNull);
  }

  void expectFirstAndLastAreEqualTo(LinkedListEntry x, [LinkedListEntry? y]){
    expect(linkedList.first, equals(x));
    expect(linkedList.last, equals(y??x));
  }

  void expectFirstIsLinkedTo(LinkedListEntry? next, [LinkedListEntry? previous]){
    expect(linkedList.first!.next, equals(next));
  }

  void expectLastIsLinkedTo(LinkedListEntry? next, [LinkedListEntry? previous]){
    expect(linkedList.last!.next, equals(next));
  }

  void expectLinksAreCorrect(List<LinkedListEntry> entries){
    for(int i = 0; i < entries.length-1; i++)
      _expectCurrentIsLinkedToNext(entries[i], entries[i+1]);
  }

  void _expectCurrentIsLinkedToNext(LinkedListEntry current, LinkedListEntry next) {
    expect(current.next, isNotNull);
    expect(current.next, equals(next));
  }
}
