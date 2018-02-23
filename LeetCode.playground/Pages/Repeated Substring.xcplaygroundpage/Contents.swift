import Foundation

class Solution {
    func repeatedStringMatch(_ A: String, _ B: String) -> Int {
        guard !A.contains(B) else { return  1 }

        let aCount = A.count
        let bCount = B.count

        let remainder = bCount % aCount
        let reps = remainder == 0 ? bCount/aCount : 1 + (bCount-remainder)/aCount

        let repA = String(repeating: A, count: reps)

        let check: (String) -> Bool = {
            return $0.contains(B)
        }

        if check(repA)          { return reps }
        if check(repA + A)      { return reps+1 }
        if check(repA + A + A)  { return reps+2 }

        return -1
    }
}

let rsm = Solution().repeatedStringMatch

rsm("1", "1")
assert(rsm("1", "1") == 1)

rsm("11", "1")
assert(rsm("11", "1") == 1)

rsm("1", "22")
assert(rsm("1", "22") == -1)

rsm("2", "22")
assert(rsm("2", "22") == 2)

rsm("111", "1111")
assert(rsm("111", "1111") == 2)

rsm("1", "1111")
assert(rsm("1", "1111") == 4)

rsm("1234", "4123")
assert(rsm("1234", "4123") == 2)

rsm("abababaaba", "aabaaba")
assert(rsm("abababaaba", "aabaaba") == 2)
