//import Foundation
class Solution {
    func licenseKeyFormatting(_ S: String, _ K: Int) -> String {
        func strip(_ char: Character) -> Character? {
            let s = String(char)
            switch s {
            case "-": return nil
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": return char
            default: return Character(s.uppercased())
            }
        }

        let backwards = S.reversed().flatMap { char in strip(char) }

        var formatted = [Character]()
        for index in 0..<backwards.count {
            formatted.append(backwards[index])
            if index != 0, index != backwards.count-1, index % K == 0 {
                formatted.append("-")
            }
        }

        return String(formatted.reversed())
    }
}

let lkf = Solution().licenseKeyFormatting

print(lkf("5F3Z-2e-9-w", 4))
assert(lkf("5F3Z-2e-9-w", 4) == "5F3-Z2E9W")

print(lkf("2-5g-3-J", 2))
assert(lkf("2-5g-3-J", 2) == "2-5G-3J")
