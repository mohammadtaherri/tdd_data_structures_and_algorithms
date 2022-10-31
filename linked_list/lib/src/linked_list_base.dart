part of linked_list;

abstract class _LinkedListBase<E extends LinkedListEntry<E>> implements LinkedList<E>{

  @override
  get isEmpty => _size == 0;

  @override
  get size => _size;
  int _size = 0;

  @override
  get first => _first;
  E? _first;

  @override
  get last => _last;
  E? _last;

  @override
  void addFirst(E entry) {

    var oldFirst = _first;

    if(isEmpty)
      _first = _last = entry;
    else{
      entry.next = _first;
      _first = entry;
    }

    doAfterAddFirst(oldFirst);

    _size++;
  }

  void doAfterAddFirst(E? oldFirst){}

  @override
  void addLast(E entry) {
    var oldLast = _last;

    if(isEmpty)
      _first = _last = entry;
    else{
      _last!.next = entry;
      _last = entry;
    }

    doAfterAddlast(oldLast);

    _size++;
  }

  void doAfterAddlast(E? oldLast){}

  @override
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

    doAfterRemoveFirst();
    
    _size--;
  }

  void doAfterRemoveFirst(){}

}