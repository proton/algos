import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

class LinkedList<T extends Comparable<T>> {
  class Node<T> {
    T value;
    Node<T> nextNode;

    Node(T value) {
      this.value = value;
    }
  }

  private class LinkedListIterator<T> implements Iterator<T> {
    private Node<T> current;

    public LinkedListIterator(Node<T> head) {
      current = head;
    }

    @Override
    public void remove() {
      throw new UnsupportedOperationException();
    }

    @Override
    public boolean hasNext() {
      return current != null;
    }

    @Override
    public T next() {
      if (!hasNext()) return null;

      var item = current.value;
      current = current.nextNode;

      return item;
    }
  }

  private Node<T> head;
  int length = 0;

  LinkedList() {
   //
  }

  LinkedList(T[] array) {
    for (int i = 0; i < array.length; ++i) {
      push(array[i]);
    }
  }

  public T first() {
    if (length == 0) return null;
    return head.value;
  }

  public T last() {
    if (length == 0) return null;
    return _lastNode().value;
  }

  public T at(int index) {
    if (length == 0) return null;

    var node = _nodeAt(index);
    if (node == null) return null;
    return node.value;
  }

  public T push(T value) {
    var node = new Node<T>(value);
    if (head == null) {
      head = node;
    } else if (head.value.compareTo(value) >= 0) {
      var oldHead = head;
      node.nextNode = oldHead;
      head = node;
    } else {
      var prevNode = head;
      while (prevNode.nextNode != null && prevNode.nextNode.value.compareTo(value) < 0) {
        prevNode = prevNode.nextNode;
      }
      var nextNode = prevNode.nextNode;
      prevNode.nextNode = node;
      node.nextNode = nextNode;
    }
    length += 1;
    return value;
  }

  public T pop() {
    if (head == null) return null;

    var node = _preLastNode();
    var lastValue = node.nextNode.value;
    node.nextNode = null;
    length -= 1;
    return lastValue;
  }

  public T popFront() {
    if (head == null) return null;

    var oldHead = this.head;
    head = oldHead.nextNode;
    length -= 1;
    return oldHead.value;
  }

  public T remove(int position) {
    if (position == 0) return popFront();

    var prevNode = _nodeAt(position - 1);
    var nextNode = prevNode.nextNode;
    prevNode.nextNode = nextNode.nextNode;
    length -= 1;
    return nextNode.value;
  }

  public Iterator<T> iterator() {
    return new LinkedListIterator<T>(head);
  }

  public Boolean contains(T searchValue) {
    var node = this.head;
    while(node != null) {
      if (node.value == searchValue) return true;
      node = node.nextNode;
    }
    return false;
  }

  public ArrayList<T> toArray() {
    var array = new ArrayList<T>();
    var it = iterator();
    for (int i = 0; i < length; ++i) {
      array.add(it.next());
    }
    return array;
  }

  private Node<T> _lastNode() {
    var node = this.head;
    while(node != null && node.nextNode != null) {
      node = node.nextNode;
    }
    return node;
  }

  private Node<T> _preLastNode() {
    var node = this.head;
    while(node != null && node.nextNode !=null && node.nextNode.nextNode != null) {
      node = node.nextNode;
    }
    return node;
  }

  private Node<T> _nodeAt(int index) {
    int counter = 0;
    var node = this.head;
    while(node != null && counter < index) {
      node = node.nextNode;
      counter += 1;
    }
    return node;
  }

  // public static void main(String[] args) {
  //   var list = new LinkedList<Integer>();
  //   assert list.toArray().equals(List.of());
  //   assert list.length == 0;

  //   Integer[] init = {};
  //   list = new LinkedList<Integer>(init);
  //   assert list.toArray().equals(List.of());
  //   assert list.length == 0;

  //   Integer[] init2 = {3, 2, 1};
  //   list = new LinkedList<Integer>(init2);
  //   assert list.toArray().equals(List.of(1, 2, 3));
  //   assert list.length == 3;
  //   assert !list.contains(0);
  //   assert list.contains(1);
  //   assert list.contains(2);
  //   assert list.contains(3);
  //   assert !list.contains(4);

  //   list.push(4);
  //   assert list.length == 4;
  //   list.push(0);
  //   assert list.toArray().equals(List.of(0, 1, 2, 3, 4));
  //   assert list.length == 5;

  //   assert list.pop() == 4;
  //   assert list.length == 4;
  //   assert list.popFront() == 0;
  //   assert list.length == 3;

  //   list.push(9);
  //   assert list.toArray().equals(List.of(1, 2, 3, 9));
  //   assert list.length == 4;

  //   list.remove(0);
  //   assert list.toArray().equals(List.of(2, 3, 9));
  //   assert list.length == 3;

  //   list.remove(1);
  //   assert list.toArray().equals(List.of(2, 9));
  //   assert list.length == 2;

  //   assert list.at(0) == 2;
  //   assert list.at(1) == 9;
  //   assert list.at(2) == null;
  // }
}
