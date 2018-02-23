//: Playground - noun: a place where people can play

import UIKit

class Node{
    var value : String
    var children : [Node] = []
    weak var Parent: Node?
    init (value : String){
        self.value = value
    }
    func add(child : Node){
        children.append(child)
        child.Parent = self
    }
}
//利用自定义字符转换，将树结构中的内容打印出来 具有普适性 directly copy
extension Node : CustomStringConvertible{
    var description : String{
        var text = "\(value)"
        if !children.isEmpty {
            text += "{" + children.map{ $0.description }.joined(separator: ",") + "}"
        }
        return text
    }
}
/* Second Method
         if !children.isEmpty{
            text += "{"
            for child in children{
                if children.last?.value != child.value{
                    text += child.description + ","
                }else{
                    text += child.description
                }
            }
            text += "}"
        }
 */

let beverages = Node(value: "beverages")
let hotBeverages = Node(value: "hot")
let coldBeverages = Node(value: "Cold")
let tea = Node(value: "tea")
let coffee = Node(value: "coffee")
let cocoa = Node(value: "cocoa")
let soda = Node(value: "soda")
let milk = Node(value: "milk")

beverages.add(child: hotBeverages)
beverages.add(child: coldBeverages)

hotBeverages.add(child: tea)
hotBeverages.add(child: coffee)
hotBeverages.add(child: cocoa)
coldBeverages.add(child: soda)
coldBeverages.add(child: milk)
//print(beverages)

extension Node{
    func search(value :  String) -> Node?{
        if value == self.value{
            return self
        }
        for child in children{
            if let found = child.search(value : value){
                return found
            }
        }
        return nil
    }
}
//print(beverages.search(value: "milk"))
//print(beverages.search(value: "lemon tea"))


/* general-propose tree 所谓的泛型结构树*/
class Node2<T>{
    var value : T
    weak var parent : Node2?
    var children : [Node2] = []
    init(value : T){
        self.value = value
    }
    func add(child : Node2){
        children.append(child)
        child.parent = self
    }
}
let company = Node2(value: "Company")
let management = Node2(value: "management")
let industry = Node2(value: "industry")
company.add(child: management)
company.add(child: industry)

extension Node2 where T : Equatable{
    func search(value : T) -> Node2? {
        if value == self.value{
            return self
        }
        for child in children{
            if let found = child.search(value: value){
                return found
            }
        }
        return nil
    }
}
print(company.search(value: "industry"))
print(company.search(value: "test"))


