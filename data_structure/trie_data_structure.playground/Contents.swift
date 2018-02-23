//: Playground - noun: a place where people can play

import UIKit

class TrieNode<T : Hashable>{
    var value : T?
    weak var parent : TrieNode?
    var children : [T : TrieNode] = [:]
    var isTerminating = false
    init(value : T? = nil, parent : TrieNode? = nil){
        self.value = value
        self.parent = parent
    }
    func add(child : T){
        guard children[child] == nil else { return }
        children[child] = TrieNode(value: child, parent: self)
    }
}


class Trie{
    typealias Node = TrieNode<Character>
    fileprivate let root : Node
    init(){
        root = Node()
    }
}
extension Trie{
    func insert(word : String){
        guard !word.isEmpty else { return }
        var currentNode = root
        let characters = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < characters.count{
            
            let character = characters[currentIndex]
            if let child = currentNode.children[character]{
                currentNode = child
            }else{
                currentNode.add(child : character)
                currentNode = currentNode.children[character]!
            }
            currentIndex += 1
        }
        if currentIndex == characters.count{
            currentNode.isTerminating = true
        }
    }
    func contains(word : String) -> Bool{
        guard !word.isEmpty else{ return false }
        var currentNode = root
        let characters = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < characters.count ,  let child = currentNode.children[characters[currentIndex]]{
            currentIndex += 1
            currentNode = child
        }
        if currentIndex == characters.count && currentNode.isTerminating{
            return true
        }else{
            return false
        }
    }
}
extension TrieNode : CustomStringConvertible{
    var description : String{
        var text = "\(String(describing: value))"
        if !children.isEmpty {
            text += "{" + children.map{ $0.value.description }.joined(separator: ",") + "}"
        }
        return text
    }
}

let trie = Trie()
trie.insert(word: "Cute")
trie.contains(word: "cut")



