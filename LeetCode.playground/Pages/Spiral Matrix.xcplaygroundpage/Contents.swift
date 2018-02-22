import Foundation

class Solution {
    private func spiral(_ matrix: [[Int]], _ position: Int, _ accumulator: inout [Int]) -> [Int] {
        //MARK: Edge Cases
        guard !matrix.isEmpty,
            matrix.count > 2*position,
            matrix[position].count > 2*position else { return accumulator }

        let height: Int = matrix.count - position
        let width:  Int = matrix[position].count - position
        guard width > 0, height > 0 else { return accumulator }

        if height == 1, width == 1 {
            print("a")
            //print("\(position), \(position)")
            accumulator.append(matrix[position][position])
            return accumulator
        } else if height == 1 {
            print("b")
            accumulator += matrix[position][position..<width-position]
            return accumulator
        } else if width == 1 {
            print("c")
            for index in position..<height-position {
                accumulator.append(matrix[index][position])
            }
            return accumulator
        }

        //MARK: Everything Else
        for index in position..<width {
            //print("h: \(height) w: \(width)")
//            print("1: (\(position), \(index))")
            accumulator.append(matrix[position][index])                 //top row
        }

        for index in position+1..<height {
            //print("h: \(height) w: \(width)")
//            print("2: (\(index), \(height-1))")
//            print(accumulator)
            accumulator.append(matrix[index][width-1])                 //right column
        }

        if width > 2 {
            for index in stride(from:position+width-2, through: position, by: -1) {
                print("3: (\(position+height-1), \(index))")
                accumulator.append(matrix[position+height-1][index])        //bottom row
            }
        }

        if height > 2 {
            for index in stride(from: position+height-2, to: position, by: -1) {
                //print("4: (\(index), \(position))")
                accumulator.append(matrix[index][position])                 //left column
            }
        }
        return spiral(matrix, position+1, &accumulator)
    }

    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var output = [Int]()

        return spiral(matrix, 0, &output)
    }
}

let so = Solution().spiralOrder

let s1 = [[Int]]()
assert(so(s1) == [])

let s2 = [[1]]
assert(so(s2) == [1])

let s3 = [[1, 2, 3]]
assert(so(s3) == [1,2,3])

let s4 = [[1],[2],[3]]
assert(so(s4) == [1,2,3])

let s5 = [ [ 1, 2, 3 ],
           [ 4, 5, 6 ],
           [ 7, 8, 9 ] ]
assert(so(s5) == [1,2,3,6,9,8,7,4,5])

let s6 = [ [ 1, 2, 3, 4, 5 ],
           [ 6, 7, 8, 9,10 ] ]
assert(so(s6) == [1,2,3,4,5,10,9,8,7,6])

let s7 = [ [ 1, 2 ],
           [ 3, 4 ],
           [ 5, 6 ],
           [ 7, 8 ],
           [ 9,10 ] ]
print(so(s7))
//assert(so(s7) == [1,2,4,6,8,10,9,7,5,3])


