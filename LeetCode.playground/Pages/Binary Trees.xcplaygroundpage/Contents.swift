import Foundation
//Heaps should be implmented as arrays, but am doing this for practice.

class BinarySearchTree<T: Comparable>: Tree<T> {
    private var bstParent: BinarySearchTree?
    override var parent: Tree<T>? {
        get {
            return self.bstParent
        }
        set {
            if newValue is BinarySearchTree {
                self.bstParent = newValue as? BinarySearchTree
            } else {
                fatalError("Wrong kind of Tree")
            }
        }
    }

    private var bstLeft: BinarySearchTree?
    override var left: Tree<T>? {
        get {
            return self.bstLeft
        }
        set {
            if newValue is BinarySearchTree {
                self.bstLeft = newValue as? BinarySearchTree
            } else {
                fatalError("Wrong kind of Tree")
            }
        }
    }

    private var bstRight: BinarySearchTree?
    override var right: Tree<T>? {
        get {
            return self.bstRight
        }
        set {
            if newValue is BinarySearchTree {
                self.bstRight = newValue as? BinarySearchTree
            } else {
                fatalError("Wrong kind of Tree")
            }
        }
    }

    var minimum: BinarySearchTree {
        var _minimum = self

        while let next = _minimum.bstLeft {
            _minimum = next
        }

        return _minimum
    }

    var maximum: BinarySearchTree {
        var _maximum = self
        while let next = _maximum.bstRight {
            _maximum = next
        }
        return _maximum
    }

    var previous: BinarySearchTree? {
        var _previous: BinarySearchTree? = nil

        if let left = self.bstLeft {
            _previous = left.maximum
        } else {
            var current = self
            while let parent = current.bstParent {
                if parent.value < self.value {
                    _previous = parent
                }
                current = parent
            }
        }

        return _previous
    }

    var next: BinarySearchTree? {
        var _next: BinarySearchTree? = nil

        if let right = self.bstRight {
            _next = right.minimum
        } else {
            var current = self
            while let parent = current.bstParent {
                if parent.value > self.value {
                    _next = parent
                }
                current = parent
            }
        }

        return _next
    }

    func search(_ value: T) -> BinarySearchTree? {
        if value < self.value {
            return self.bstLeft?.search(value)
        } else if value > self.value {
            return self.bstRight?.search(value)
        } else {
            return self
        }
    }

    func contains(value: T) -> Bool {
        return self.search(value) != nil
    }

    func insert(_ value: T) {
        if value < self.value {
            if let left = self.bstLeft {
                left.insert(value)
            } else {
                self.left = BinarySearchTree(value)
                left?.parent = self
            }
        } else {
            if let right = self.bstRight {
                right.insert(value)
            } else {
                self.right = BinarySearchTree(value)
                right?.parent = self
            }
        }
    }

    @discardableResult
    func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?

        if let right = self.bstRight {
            replacement = right.minimum
        } else if let left = self.left as? BinarySearchTree {
            replacement = left.maximum
        } else {
            replacement = nil
        }

        replacement?.remove()

        replacement?.right = self.right
        replacement?.left = self.left
        right?.parent = replacement
        left?.parent = replacement

        self.reconnect(replacement)

        self.parent = nil
        self.left = nil
        self.right = nil

        return replacement
    }

    func reconnect(_ node: BinarySearchTree?) {
        guard let parent = self.bstParent else { return }
        if self.isLeftChild {
            parent.left = node
        } else {
            parent.right = node
        }
        node?.parent = parent
    }
}

class Tree<T> {
    var value: T
    var parent: Tree?
    var left: Tree?
    var right: Tree?

    init(_ value: T) {
        self.value = value
    }

    var isRoot: Bool {
        return parent == nil
    }

    var isLeaf: Bool {
        return left == nil && right == nil
    }

    var isLeftChild: Bool {
        return parent?.left === self
    }

    var isRightChild: Bool {
        return parent?.right === self
    }

    var hasLeftChild: Bool {
        return left != nil
    }

    var hasRightChild: Bool {
        return right != nil
    }

    var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }

    var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }

    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }

    var depth: Int {
        var current = self
        var _depth = 0

        while let parent = current.parent {
            current = parent
            _depth += 1
        }

        return _depth
    }

    var height: Int {
        guard !self.isLeaf else { return 0 }
        let leftHeight  = self.left?.height ?? 0
        let rightHeight = self.right?.height ?? 0

        return 1 + max(leftHeight, rightHeight)
    }

    func traverseInOrder(process: (T) -> Void) {
        self.left?.traverseInOrder(process: process)
        process(value)
        self.right?.traverseInOrder(process: process)
    }

    func traversePreOrder(process: (T) -> Void) {
        process(value)
        self.left?.traversePreOrder(process: process)
        self.right?.traversePreOrder(process: process)
    }

    func traversePostOrder(process: (T) -> Void) {
        self.left?.traversePostOrder(process: process)
        self.right?.traversePostOrder(process: process)
        process(value)
    }


}

//MARK: CustomDebugStringConvertible conformance
extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        var output = String()
        if let left = self.bstLeft {
            output += "(\(left.description)) <- "
        }
        output += "\(value)"
        if let right = self.bstRight {
            output += " -> (\(right.description))"
        }
        return output
    }
}

let bst = BinarySearchTree<Int>(0)
let someValues = [2,5,4,7,3,9,20,18,11,14]

someValues.forEach { bst.insert($0) }

var values = String()
bst.traverseInOrder { val in
    values += "\(val) "
}
print(values)
print(bst)


