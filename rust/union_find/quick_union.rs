pub struct QuickUnion {
  parents: Vec<usize>,
  length:  usize,
}

impl QuickUnion {
  pub fn new(n: usize) -> QuickUnion {
    Self {
      parents: (0..n).collect::<Vec<_>>(),
      length:  n,
    }
  }

  pub fn is_connected(&self, a: usize, b: usize) -> bool {
    return self.root(a) == self.root(b);
  }

  pub fn union(&mut self, a: usize, b: usize) {
    let a_root = self.root(a);
    let b_root = self.root(b);

    if a_root == b_root {
      return;
    }

    self.parents[b_root] = a_root;

    self.length -= 1;
  }

  fn root(&self, mut x: usize) -> usize {
    while x != self.parents[x] {
      x = self.parents[x];
    }
    return x;
  }
}

// pub fn main() {
//   let mut uf = QuickUnion::new(10);
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