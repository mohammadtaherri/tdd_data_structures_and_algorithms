part of linked_list;


class DoublyLinkedList<E extends DoublyLinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  void doAfterAddFirst(E? oldFirst){
    if(oldFirst == null)
      return;

    oldFirst.previous = _first;
  }

  @override
  void doAfterAddlast(E? oldLast){
    if(oldLast == null)
      return;

    _last!.previous = oldLast;
  }

  @override
  void doAfterRemoveFirst(){
    if(_first == null)
      return;

    _first!.previous = null;
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
