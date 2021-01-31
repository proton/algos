public class SelectionSort {
  public static <T extends Comparable<T>> void bubble_sort(T[] array) {    
    for (int i = 0; i < array.length; ++i) {
      int minIdx = i;
      for (int j = i + 1; j < array.length; ++j) {
        if (array[j].compareTo(array[minIdx]) < 0) {
          minIdx = j;
        }
      }
      if (i != minIdx) {
        T buf = array[i];
        array[i] = array[minIdx];
        array[minIdx] = buf;
      }
    }
  }
}