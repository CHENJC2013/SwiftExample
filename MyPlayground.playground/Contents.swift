import UIKit

var str = "Hello, playground"

class Animal {
    var name: String?
    var weight = 0.0
}

extension Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name && lhs.weight == rhs.weight
    }
}

let cat = Animal()
cat.name = "cat"
cat.weight = 10

let blackCat = cat
blackCat.name = "catName"

let whiteCat = Animal()
whiteCat.name = "catName"
whiteCat.weight = 10.0

if blackCat === cat {
    print("Identical") //Identical
} else {
    print("Not identical")
}

if whiteCat === blackCat {
    print("Identical")
} else {
    print("Not identical") //Not identical
}

if whiteCat == blackCat {
    print("Equal")
} else {
    print("Not Equal") //Equal
}
//------------------------------------------
struct FPoint {
    var x = 0.0
    var y = 0.0
    //当在struct修改属性的时候需要使用mutating
    mutating func addX(add: Double) {
        self.x = self.x + add
    }
}

let p1 = FPoint()
print("p1's x : \(p1.x), p1's y: \(p1.y)") // p1's x : 0.0, p1's y: 0.0

var p2 = p1
p2.x = 3.0
print("p1's x : \(p1.x), p1's y: \(p1.y); p2's x : \(p2.x), p2's y: \(p2.y)")

