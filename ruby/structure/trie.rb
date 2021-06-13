# TODO: unfinished

class TrieNode
  attr_accessor :children, :count

  def initialize
    @count    = 0
    @children = {}
  end
end

class Trie
  attr_reader :root, :text

  REGEX = /[a-zA-Z0-9]+/

  def initialize(text)
    @text = text
    @root = TrieNode.new

    text.scan(REGEX).each do |word|
      add(word.downcase)
    end
  end

  def count(string)
    node = root
    string.each_char do |char|
      node = node.children[char]
      return 0 if node.nil?
    end
    node.count
  end

  private def add(word)
    node = root
    word.each_char.with_index do |char, index|
      node.children[char] ||= TrieNode.new
      node = node.children[char]
    end
    node.count += 1
  end
end

text = <<~TEXT
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
TEXT

trie = Trie.new(text)

fail unless trie.count("dolor") == 2
fail unless trie.count("ipsum") == 1
fail unless trie.count("lorem") == 1
fail unless trie.count("nonexistent") == 0
