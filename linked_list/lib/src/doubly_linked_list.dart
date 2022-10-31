part of linked_list;


class DoublyLinkedList<E extends DoublyLinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  void doAfterAddFirst(E? oldFirst){
    oldFirst?.previous = _first;
  }

  @override
  void doAfterAddlast(E? oldLast){
    _last!.previous = oldLast;
  }

  @override
  void doAfterRemoveFirst(){
    _first?.previous = null;
  }

  @override
  E? nodeBefore(E node) {
    return node.previous;
  }

  @override
  void doAfterRemoveLast(E? oldLast){
    oldLast?.previous = null;
  }

  @override
  E elementAt(int index) {
    if(isEmpty)
      throw Empty();

    if(index < 0 || index >= _size)
      throw OutOFRange();

    for (var i = 0, current = _first; current != null; i++, current = current.next) 
      if (i == index) 
        return current;
  
    throw Error();
  }

  @override
  int indexOf(E entry) {
    for(var i = 0, current = _first; current != null; i++, current = current.next)
      if(current == entry)
        return i;
    
    return -1;
  }

  @override
  void reverse() {
  }
}

class DoublyLinkedListEntry<E extends DoublyLinkedListEntry<E>> extends LinkedListEntry<E> {
  E? previous;
}
