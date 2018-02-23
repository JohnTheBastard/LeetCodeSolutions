import Foundation

class Solution {
    private var memo = [Int: Int]()

    func fibonacci( _ n: Int) -> Int {
        guard n > 0  else { return 0 }
        guard n != 1 else { return 1 }
        if let fib = memo[n] { return fib }

        let result = fibonacci(n-1) + fibonacci(n-2)
        memo[n] = result

        return result
    }

    func fastFib(_ n: Int) -> Int {
        guard n > 0  else { return 0 }
        guard n != 1 else { return 1 }

        let n: Double = Double(n)
        let sqrt5 = Double(5).squareRoot()

        let Φ: Double = (1 + sqrt5) / 2
        let ϕ: Double = (1 - sqrt5) / 2

        return Int( round( (pow(Φ,n)+pow(ϕ, n))/sqrt5 ) )
    }
}

let x = Solution()
let fib = x.fibonacci
let ff  = x.fastFib

for ii in 0...55 {
    print("\(ff(ii)) == \(fib(ii))")
    assert( ff(ii) == fib(ii) )
}
