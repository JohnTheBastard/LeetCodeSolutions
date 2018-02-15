class Solution {
    func licenseKeyFormatting(_ S: String, _ K: Int) -> String {
        func strip(_ char: Character) -> Character? {
            let s = String(char)
            switch s {
            case "-": return nil
            default: return s.uppercased().first
            }
        }

        let backwards = S.reversed().flatMap { char in strip(char) }

        var formatted = [Character]()
        for index in 0..<backwards.count {
            if index % K == 0,index != 0{ formatted.append("-") }
            formatted.append(backwards[index])
        }

        return String(formatted.reversed())
    }
}

let lkf = Solution().licenseKeyFormatting

print(lkf("5F3Z-2e-9-w", 4))
assert(lkf("5F3Z-2e-9-w", 4) == "5F3Z-2E9W")

print(lkf("2-5g-3-J", 2))
assert(lkf("2-5g-3-J", 2) == "2-5G-3J")

print(lkf("2-5g-3-J2-5g-3-J2-5g-3-J2-5g-3-J2-5g-3-J2-5g-3-J", 4))

