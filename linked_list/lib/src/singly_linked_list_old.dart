part of linked_list;

class SinglyLinkedListOld<E extends LinkedListEntryOld<E>> {

  get isEmpty => _size == 0;
  get size => _size;
  int _size = 0;

  E? get first => _first;
  E? _first;
  E? get last => _last;
  E? _last;

  void addFirst(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      entry.next = _first;
      _first = entry;
    }
      
    _size++;
  }

  void addLast(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      _last!.next = entry;
      _last = entry;
    }

    _size++;
  }

  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      var newFirst = first!.next;
      _first!.next = null;
      _first = newFirst;
    }
      

    _size--;
  }

  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      E newLsat = _nodeBefore(_last!)!;
      newLsat.next = null;
      _last = newLsat;
    }
      
    _size--;
  }

  E? _nodeBefore(E node) {
    var current = _first;

    while (current != null) {
      if (current.next == node) 
        return current;
      
      current = current.next;
    }

    return null;
  }
  
}

abstract class LinkedListEntryOld<E extends LinkedListEntryOld<E>>{
  E? next;
}


