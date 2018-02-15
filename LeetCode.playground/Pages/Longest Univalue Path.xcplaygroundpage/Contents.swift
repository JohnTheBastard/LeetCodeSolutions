//         a
//       /   \
//      /     \
//     b       c
//    / \     / \
//   d   e   f   g
public func make3(_ a: Int,
                  _ b: Int? = nil, _ c: Int? = nil, _ d: Int? = nil,
                  _ e: Int? = nil, _ f: Int? = nil, _ g: Int? = nil) -> TreeNode {

    let A = TreeNode(a)

    if let B = TreeNode(b) {
        A.left = B
        B.left = TreeNode(d)
        B.right = TreeNode(e)
    }

    if let C = TreeNode(c) {
        A.right = C
        C.left = TreeNode(f)
        C.right = TreeNode(g)
    }

    return A
}

/**
 * Definition for a binary tree node.
 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?

    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    public convenience init?(_ value: Int?) {
        if let value = value {
            self.init(value)
        } else {
            return nil
        }
    }
}

class Solution {
    func longestUnivaluePath(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxPathLength = 0
        var longPaths = Set<Int>()

        func longestDownPathThrough(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            var length = 0
            if let left = root.left, root.val == left.val {
                length += 1
                length += longestPathDownFrom(left)
            }

            if let right = root.right, root.val == right.val {
                length += 1
                length += longestPathDownFrom(right)
            }

            longPaths.insert(length)
            return length
        }

        func longestPathDownFrom(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            var leftPathDown  = 0
            var rightPathDown = 0

            if let left = root.left, root.val == left.val {
                leftPathDown += 1
                leftPathDown += longestPathDownFrom(left)
            }

            if let right = root.right, root.val == right.val {
                rightPathDown += 1
                rightPathDown += longestPathDownFrom(right)
            }

            return max(leftPathDown, rightPathDown)
        }

        func searchPaths(_ root: TreeNode?) {
            guard let root = root else { return }
            longestDownPathThrough(root)
            searchPaths(root.left)
            searchPaths(root.right)
        }

        searchPaths(root)

        return longPaths.max() ?? 0
    }
}

let lup = Solution().longestUnivaluePath

//print(lup(TreeNode(0)))
assert(lup(TreeNode(0)) == 0)


//       5
//      / \
//     4   5
//    / \   \
//   1   1   5
let sample1 = make3(5,4,5,1,1,nil,5)
print(lup(sample1))
assert(lup(sample1) == 2)

//       1
//      / \
//     5   4
//    /   / \
//   5   4   4
let sample2 = make3(1,5,4,5,nil,4,4)
//print(lup(sample2))
assert(lup(sample2) == 2)

//       4
//      / \
//     4   4
//    / \   \
//   4   4   5
let sample3 = make3(4,4,4,4,4,nil,5)
//print(lup(sample3))
assert(lup(sample3) == 3)

//         4
//        / \
//     4       4
//    / \     / \
//   4   4   4   4
let sample4 = make3(4,4,4,4,4,4,4)
//print(lup(sample4))
assert(lup(sample4) == 4)



