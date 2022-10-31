part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  E? nodeBefore(E node) {
    for (var current = _first; current != null; current = current.next)
      if (current.next == node) return current;

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

    var prev = first;
    var current = prev?.next;

    while(current != null){
      var temp = current.next;
      current.next = prev;
      prev = current;
      current = temp;
    }

    var temp = _first;
    _first = _last;
    _last = temp;
    
    _last?.next = null;
  }
}

