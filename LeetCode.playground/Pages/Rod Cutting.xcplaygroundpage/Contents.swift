import Foundation

infix operator %%
extension Int {
    static func %% (dividend: Int, divisor: Int) -> (Int, Int, Int) {
        let remainder = dividend % divisor
        let nq = dividend - remainder
        let quotient = nq / divisor
        return (quotient: quotient, characteristic: nq, remainder: remainder)
    }
}

struct Segment: Equatable {
    let length: Int
    let price: Int
    let normalizedValue: Float

    init(_ length: Int, _ price: Int) {
        self.length = length
        self.price = price
        self.normalizedValue = length > 0 ? Float(price)/Float(length) : 0

    }

    static func == (lhs: Segment, rhs: Segment) -> Bool {
        return  lhs.length == rhs.length && lhs.price == rhs.price
    }
}

infix operator <+>
extension Array where Element == Segment {
    var price: Int {
        return self.reduce(0, { (val, seg) in val + seg.price })
    }

    var best: Segment {
        return self.max { $0.normalizedValue < $1.normalizedValue } ?? Segment(0,0)
    }

    static func < (lhs: [Element], rhs: [Element]) -> Bool {
        return lhs.price < rhs.price
    }

    static func <+> (lhs: [Element], rhs: [Element]) -> [Element] {
        guard lhs != [] else { return rhs }
        guard rhs != [] else { return lhs }
        return lhs + rhs
    }
}

class Rod {
    private var segments: [[Segment]]
    var memo: [[Segment]] = []

    private func max(_ lhs: [Segment], _ rhs: [Segment]) -> [Segment] {
        return lhs < rhs ? rhs : lhs
    }

    init(_ prices: [Int]) {
        guard prices.count > 0 else { fatalError("Invalid prices") }
        segments = prices.enumerated().map { [Segment($0.0, $0.1)] }
        segments[0] = []

        memo.append(segments[0])
        memo.append(segments[1])
    }


    func optimalCuts(_ length: Int) -> [Segment] {
        guard length >= memo.count else { return memo[length] }

        for ii in memo.count...length {
            var max_ii: [Segment]

            if ii < segments.count {
                max_ii = segments[ii]

                for jj in 1..<ii {
                    max_ii = self.max( max_ii, segments[jj]<+>memo[ii-jj] )
                }
            } else {

                let bestLength = segments.dropFirst().map({$0[0]}).best.length
                let (quotient,_,remainder) = ii %% bestLength
                let cuts = Array(repeatElement(segments[bestLength][0], count: quotient))
                max_ii = cuts<+>memo[remainder]
            }

            memo.append(max_ii)
        }

        return memo[length]
    }
}

let prices = [0,1,5,8,9,10,17,17,20,24,30]

let rod = Rod(prices)

print(rod.optimalCuts(10).map { $0.length })
print(rod.optimalCuts(91).map { $0.length })

rod.memo.enumerated().forEach { (index, segments) in
    var out = "\(index):  [  "
    segments.forEach { segment in
        out += "\(segment.length)  "
    }
    out += "]"
    print("\(out)    price: \(segments.price)")
}




