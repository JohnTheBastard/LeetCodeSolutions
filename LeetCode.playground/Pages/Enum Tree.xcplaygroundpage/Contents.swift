indirect enum Tree<T> {
    case node(Tree<T>, T, Tree<T>)
    case empty
}

let one = Tree.node(.empty, 1, .empty)




