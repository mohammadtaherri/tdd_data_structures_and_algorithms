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

    afterAddlast(oldLast);

    _size++;
  }

  void afterAddlast(E? oldLast){}

}