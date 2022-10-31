library linked_list;

part './src/linked_list_base.dart';
part './src/singly_linked_list.dart';
part './src/circular_linked_list.dart';
part './src/doubly_linked_list.dart';
part './src/errors.dart';


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

