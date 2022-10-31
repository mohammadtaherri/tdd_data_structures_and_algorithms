part of linked_list;


class DoublyLinkedList<E extends DoublyLinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  void afterAddFirst(E? oldFirst){
    if(oldFirst == null)
      return;

    oldFirst.previous = _first;
  }

  @override
  void addLast(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      _last!.next = entry;
      entry.previous = _last;
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
      newFirst!.previous = null;
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
      var newlast = _last!.previous;
      _last!.previous = null;
      newlast!.next = null;
      _last = newlast;
    }
    
    _size--;
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
