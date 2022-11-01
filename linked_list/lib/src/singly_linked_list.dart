part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

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

