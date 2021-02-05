pub struct QuickFind {
  parents: Vec<usize>,
  length:  usize,
}

impl QuickFind {
  pub fn new(n: usize) -> QuickFind {
    Self {
      parents: (0..n).collect::<Vec<_>>(),
      length:  n,
    }
  }

  pub fn is_connected(&self, a: usize, b: usize) -> bool {
    return self.parents[a] == self.parents[b];
  }

  pub fn union(&mut self, a: usize, b: usize) {
    let a_root = self.parents[a];
    let b_root = self.parents[b];

    if a_root == b_root {
      return;
    }

    for i in 0..self.parents.len() {
      if self.parents[i] == b_root {
        self.parents[i] = a_root;
      }
    }

    self.length -= 1;
  }
}

// pub fn main() {
//   let mut uf = QuickFind::new(10);
//   uf.union(4, 3);
//   uf.union(3, 8);
//   uf.union(6, 5);
//   uf.union(9, 4);
//   uf.union(2, 1);

//   assert!(uf.length == 5);
//   assert!(uf.is_connected(0, 7) == false);
//   assert!(uf.is_connected(8, 9) == true);

//   uf.union(5, 0);
//   uf.union(7, 2);
//   uf.union(6, 1);
//   uf.union(1, 0);

//   assert!(uf.length == 2);
//   assert!(uf.is_connected(0, 7) == true);
// }