

import 'package:linked_list_composition/linked_list.dart';

class SinglyLinkedList<E extends LinkedListEntry<E>> implements LinkedList<E>{

  @override
  bool get isEmpty => _size == 0;

  @override
  int get size => _size;
  int _size = 0;

  @override
  E? get first => _first;
  E? _first;

  @override
  E? get last => _last;
  E? _last;

  @override
  void addFirst(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      entry.next = _first;
      _first = entry;
    }
    
    _size++;
  }

  @override
  void addLast(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      _last!.next = entry;
      _last = entry;
    }
    
    _size++;
  }

  @override
  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      var newFirst = _first!.next;
      _first!.next = null;
      _first = newFirst;
    }

    _size--;
  }

  @override
  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      var newLast = _nodeBefor(_last!)!;
      newLast.next = null;
      _last = newLast;
    }

    _size--;
  }

  E? _nodeBefor(E node) {
    
    for (var current = _first; current != null; current = current.next) 
      if (current.next == _last) 
        return current;

    return null;
  }

  @override
  E elementAt(int index) {
    if(isEmpty)
      throw Empty();

    if(index < 0 || index >= size)
      throw OutOFRange();

    for(var i = 0, current = first; i <= index; i++, current = current?.next)
      if(i == index)
        return current!;

    throw Error();
  }

  @override
  int indexOf(E entry) {
    for (var c = _first, i = 0; c != null; c = c.next, i++)
      if (c == entry) 
        return i;

    return -1;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;

    var previous = first;
    var current = first!.next;

    while(current != null){
      var temp = current.next;
      current.next = previous;
      previous = current;
      current = temp;
    }

    var temp = first;
    _first = _last;
    _last = temp;

    last!.next = null;
  }

  
}