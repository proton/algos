public class LinearSearch {    
  public static <T extends Comparable<T>> int linearSearch(T[] array, T n) {    
    for(int i = 0 ; i < array.length; ++i) {    
      if (array[i].equals(n)) return i;  
    }    
    return -1;
  }
}