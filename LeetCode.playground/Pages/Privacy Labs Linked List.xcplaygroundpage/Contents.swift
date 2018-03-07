import Foundation

class List<T> {
    class Node<T> {
        var value: T
        var next: Node?

        init(_ value: T) {
            self.value = value
        }
    }

    var head: Node<T>
    var tail: Node<T>

    init(_ value: T) {
        self.head = Node(value)
        self.tail = self.head
    }

    func add(_ value: T) {
        self.tail.next = Node(value)
        if let next = self.tail.next {
            self.tail = next
        }
    }

    func printList() {
        print(self.head.value)
        var current: Node = self.head

        while let next = current.next {
            print(next.value)
            current = next
        }
    }

    @discardableResult
    func reverseList() -> List {
        let originalHead = self.head
        var pointer1 = self.head.next
        var pointer2 = self.head.next?.next

        repeat {
            if let pointer1 = pointer1 {
                pointer1.next = self.head
                self.head = pointer1
            }
            pointer1 = pointer2
            pointer2 = pointer2?.next

        } while pointer1 != nil

        self.tail = originalHead
        self.tail.next = nil

        return self
    }
}

var myList = List(1)

for ii in 2...10 {
    myList.add(ii)
}

myList.printList()
myList.reverseList()
myList.printList()


