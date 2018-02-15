import Foundation

class Solution {
    func nct(_ time: String) -> String {
        let components = time.split(separator: ":")
        var hours      = Int(components[0])!
        var minutes    = Int(components[1])!

        var digits     = Array<Character>(time).reduce(into: Set<Int>()) { (set, char) in
            if let digit = asDigit(char) { set.insert(digit) }
        }

        func padded(_ ii: Int) -> String {
            var str = "\(ii)"
            if str.count == 1 { str = "0\(ii)" }
            return str
        }

        func asDigit(_ character: Character) -> Int? {
            switch String(character) {
            case "0": return 0
            case "1": return 1
            case "2": return 2
            case "3": return 3
            case "4": return 4
            case "5": return 5
            case "6": return 6
            case "7": return 7
            case "8": return 8
            case "9": return 9
            default:  return nil
            }
        }

        func tryIt(_ candidate: Int) -> String {
            let possible = padded(candidate)

            let chars = Array<Character>(possible)
            if let left   = asDigit(chars[0]), digits.contains(left),
                let right = asDigit(chars[1]), digits.contains(right) { return possible }

            return String()
        }

        func iterate(start: Int, mod: Int) -> String {
            var next = String()
            var ii: Int = start

            repeat {
                ii = (ii + 1) % mod
                next = tryIt(ii)
            } while next.isEmpty

            return next
        }

        let nextMinute: String = iterate(start: minutes, mod: 60)

        let nextHour: String = {
            guard minutes >= Int(nextMinute)! else { return padded(hours) }
            return iterate(start: hours, mod: 24)
        }()

        return "\(nextHour):\(nextMinute)"
    }
}

let x = Solution()


assert(x.nct("19:34") == "19:39")
assert(x.nct("23:59") == "22:22")
assert(x.nct("22:22") == "22:22")
assert(x.nct("01:34") == "01:40")
assert(x.nct("01:01") == "01:10")
assert(x.nct("13:55") == "15:11")
print("19:34 -> \(x.nct("19:34"))")
print("23:59 -> \(x.nct("23:59"))")
print("22:22 -> \(x.nct("22:22"))")
print("01:34 -> \(x.nct("01:34"))")
print("01:01 -> \(x.nct("01:01"))")
print("13:55 -> \(x.nct("13:55"))")


