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
        [ 0:"",              1:"One",          2:"Two",            3:"Three",          4:"Four",
          5:"Five",          6:"Six",          7:"Seven",          8:"Eight",          9:"Nine",
          10:"Ten",          11:"Eleven",      12:"Twelve",        13:"Thirteen",      14:"Fourteen",
          15:"Fifteen",      16:"Sixteen",     17:"Seventeen",     18:"Eighteen",      19:"Nineteen",
          20:"Twenty",       21:"Twenty One",  22:"Twenty Two",    23:"Twenty Three",  24:"Twenty Four",
          25:"Twenty Five",  26:"Twenty Six",  27:"Twenty Seven",  28:"Twenty Eight",  29:"Twenty Nine",
          30:"Thirty",       31:"Thirty One",  32:"Thirty Two",    33:"Thirty Three",  34:"Thirty Four",
          35:"Thirty Five",  36:"Thirty Six",  37:"Thirty Seven",  38:"Thirty Eight",  39:"Thirty Nine",
          40:"Forty",        41:"Forty One",   42:"Forty Two",     43:"Forty Three",   44:"Forty Four",
          45:"Forty Five",   46:"Forty Six",   47:"Forty Seven",   48:"Forty Eight",   49:"Forty Nine",
          50:"Fifty",        51:"Fifty One",   52:"Fifty Two",     53:"Fifty Three",   54:"Fifty Four",
          55:"Fifty Five",   56:"Fifty Six",   57:"Fifty Seven",   58:"Fifty Eight",   59:"Fifty Nine",
          60:"Sixty",        61:"Sixty One",   62:"Sixty Two",     63:"Sixty Three",   64:"Sixty Four",
          65:"Sixty Five",   66:"Sixty Six",   67:"Sixty Seven",   68:"Sixty Eight",   69:"Sixty Nine",
          70:"Seventy",      71:"Seventy One", 72:"Seventy Two",   73:"Seventy Three", 74:"Seventy Four",
          75:"Seventy Five", 76:"Seventy Six", 77:"Seventy Seven", 78:"Seventy Eight", 79:"Seventy Nine",
          80:"Eighty",       81:"Eighty One",  82:"Eighty Two",    83:"Eighty Three",  84:"Eighty Four",
          85:"Eighty Five",  86:"Eighty Six",  87:"Eighty Seven",  88:"Eighty Eight",  89:"Eighty Nine",
          90:"Ninety",       91:"Ninety One",  92:"Ninety Two",    93:"Ninety Three",  94:"Ninety Four",
          95:"Ninety Five",  96:"Ninety Six",  97:"Ninety Seven",  98:"Ninety Eight",  99:"Ninety Nine" ]

    private func hundreds(_ val: Int) -> String {
        guard val != 0 else { return "" }
        precondition(val < 1000)

        let (_, nq, r) = val %% 100
        let tens = r
        let hundreds = nq
        let tensWord = nameOfIntsUnder100[tens]!
        let hundWord = nameOfIntsUnder100[hundreds / 100]!
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

