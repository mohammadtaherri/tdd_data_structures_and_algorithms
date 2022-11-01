part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

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

