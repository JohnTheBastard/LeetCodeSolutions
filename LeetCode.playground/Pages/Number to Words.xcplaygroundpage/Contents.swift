import Foundation

/*
 Write a function converts a 32-bit integer number to english. For example, if the input is 123, return “one hundred twenty three”. If the input is 1234, return “one thousand two hundred thirty four”. Assume all numbers are non-n
 notes to self:
 handle up to billions for unsigned 32bit
 custom mod operator
 enum with associated values
 special cases for teens
 performance constraints? ugh -> bitshift...
 */

infix operator %%
extension Int {
    static func %% (dividend: Int, divisor: Int) -> (Int, Int, Int) {
        let remainder = dividend % divisor
        let nq = dividend - remainder
        let quotient = nq / divisor
        return (quotient: quotient, characteristic: nq, remainder: remainder)
    }
}

class Solution {
    private let aBillion  = 1_000_000_000
    private let aMillion  = 1_000_000
    private let aThousand = 1_000
    private let aHundred  = 100

    private let nameOfIntsUnder100 =
        [ "","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten",
          "Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen",
          "Eighteen","Nineteen","Twenty","Twenty One","Twenty Two","Twenty Three",
          "Twenty Four","Twenty Five","Twenty Six","Twenty Seven","Twenty Eight",
          "Twenty Nine","Thirty","Thirty One","Thirty Two","Thirty Three","Thirty Four",
          "Thirty Five","Thirty Six","Thirty Seven","Thirty Eight","Thirty Nine",
          "Forty","Forty One","Forty Two","Forty Three","Forty Four","Forty Five",
          "Forty Six","Forty Seven","Forty Eight","Forty Nine","Fifty","Fifty One",
          "Fifty Two","Fifty Three","Fifty Four","Fifty Five","Fifty Six","Fifty Seven",
          "Fifty Eight","Fifty Nine","Sixty","Sixty One","Sixty Two","Sixty Three",
          "Sixty Four","Sixty Five","Sixty Six","Sixty Seven","Sixty Eight","Sixty Nine",
          "Seventy","Seventy One","Seventy Two","Seventy Three","Seventy Four",
          "Seventy Five","Seventy Six", "Seventy Seven", "Seventy Eight", "Seventy Nine",
          "Eighty","Eighty One","Eighty Two","Eighty Three","Eighty Four","Eighty Five",
          "Eighty Six","Eighty Seven","Eighty Eight","Eighty Nine","Ninety","Ninety One",
          "Ninety Two","Ninety Three","Ninety Four","Ninety Five","Ninety Six",
          "Ninety Seven","Ninety Eight","Ninety Nine" ]

    private func hundreds(_ val: Int) -> String {
        guard val != 0 else { return "" }
        precondition(val < 1000)

        let (_, nq, r) = val %% 100
        let tens = r
        let hundreds = nq
        let tensWord = nameOfIntsUnder100[tens]
        let hundWord = nameOfIntsUnder100[hundreds / 100]
        return hundWord.isEmpty ? "\(tensWord) " : "\(hundWord) \(tensWord)"
    }

    private func n2w(_ val: Int) -> String {
        if val >= aBillion {
            return n2w( val / aBillion) + "Billion " + n2w(val % aBillion)
        } else if val >= aMillion {
            return n2w( val / aMillion) + "Million " + n2w(val % aMillion)
        } else if val >= aThousand {
            return n2w(val / aThousand) + "Thousand " + n2w(val % aThousand)
        } else if val >= aHundred {
            return n2w(val / aHundred) + "Hundred " + n2w(val % aHundred)
        } else {
            return hundreds(val)
        }
    }

    func numberToWords(_ num: Int) -> String {
        guard num != 0 else { return "Zero" }

        return n2w(num).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let n2w = Solution().numberToWords

print(n2w(1_234_567_899))
print(n2w(1_000_000_000))
print(n2w(1_001_001_101))
print(n2w(121_001_101))


/*
 Q2:
 Given two lists of single digit numbers, for example:

 List 1 is [4, 5, 6]  (4 is the first element of the list)
 List 2 is: [7, 8] (7 is the first)

 Write a function that treats each list as an integer number (see example below), add them together and return the result as an integer list.

 For example, for the above two lists, this function treats list 1 [4, 5, 6] as integer 456, and list 2 as integer 78. This function then calculates the sum of 456 and 78, and returns an integer
 list [5, 3, 4].
 */

