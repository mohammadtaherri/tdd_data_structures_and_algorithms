part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry>{

  bool get isEmpty => _size == 0;
  int get size => _size;
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
      E? current = _first;
      late E newLast;

      if(current != null){
        if(current.next == _last)
          newLast = current;
      }
      newLast.next = null;
      _last = newLast;
    }

    _size--;
  }

  int indexOf(E entry) {
    E? current = _first;
    int index = 0;

    if(current != null)
      if(current == entry)
        return index;
    
    return -1;
  }
}

class LinkedListEntry{
  var next;
}