library linked_list;

export './src/errors.dart';
export './src/singly_linsked_list.dart';

abstract class LinkedList<E extends LinkedListEntry<E>>{

  const LinkedList._();

  bool get isEmpty;
  int get size;

  E? get first;
  E? get last;

  void addFirst(E entry);
  void addLast(E entry);
  void removeFirst();
  void removeLast();

  E elementAt(int index);
  int indexOf(E entry);
  
  void reverse();
}

abstract class LinkedListEntry<E extends LinkedListEntry<E>>{
  E? next;
}
