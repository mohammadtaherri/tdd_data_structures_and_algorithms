part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

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

