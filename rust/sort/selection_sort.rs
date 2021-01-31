pub fn selection_sort<T: Ord>(array: &mut [T]) {
  for i in 0..array.len() {
    let mut min_idx = i;
    for j in (i + 1)..array.len() {
      if array[j] < array[min_idx] {
        min_idx = j;
      }
    }
    array.swap(i, min_idx);
  }
}