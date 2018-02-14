//: Playground - noun: a place where people can play

import Foundation

extension String {
    var backwards: String {
        let count = self.count
        guard count > 1 else { return self }

        let forwards = Array(self)
        var backwards = Array(repeating: Character(" "), count: count)

        for index in 0..<count {
            backwards[index] = forwards[count-(index+1)]
        }

        return String(backwards)
    }
}

assert("" == "".backwards)
assert("a" == "a".backwards)
assert("zyxwvutsrqponmlkjihgfedcba" == "abcdefghijklmnopqrstuvwxyz".backwards)
