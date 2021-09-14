import UIKit

// MARK: - დავალება 1

func isPalindrome(_ text: String) -> Bool {
    
    let reversedText = String(text.reversed())
    
    if(!text.isEmpty && text == reversedText) { return true }
    
    return false
}

print(isPalindrome("radar"))
print(isPalindrome("nasa"))

// MARK: - დავალება 2

func minSplit(_ amount: Int) -> Int {
    
    var cashAmount = amount
    var quantity = 0
    
    if cashAmount / 50 != 0 {
        
        quantity += cashAmount / 50
        cashAmount = cashAmount % 50
    }
    
    if cashAmount / 20 != 0 {
        
        quantity += cashAmount / 20
        cashAmount = cashAmount % 20
    }
    
    if cashAmount / 10 != 0 {
        
        quantity += cashAmount / 10
        cashAmount = cashAmount % 10
    }
    
    if cashAmount / 5 != 0 {
        
        quantity += cashAmount / 5
        cashAmount = cashAmount % 5
    }
    
    if cashAmount / 1 != 0 {
        
        quantity += cashAmount / 1
        cashAmount = cashAmount % 1
    }
    
    return quantity
    
}

print(minSplit(222))

// MARK: - დავალება 3

func notContains(_ array: [Int]) -> Int {
    
    var lowestNum = 0
    
    while true {
        
        lowestNum += 1
        
        if array.contains(lowestNum) { continue } else { break }
    }
    
    return lowestNum
    
}

print(notContains([1, 3, 4, 6]))

// MARK: - დავალება 4

func isProperly(_ sequence: String) -> Bool {

    let openBracket = Array(sequence)
    let closeBracket = Array(sequence.reversed())
    
    if sequence.count % 2 != 0 { return false }
    
    for s in 0..<sequence.count {
        
        if openBracket[s] == "(" && closeBracket[s] == ")" { continue }
        if openBracket[s] == ")" && closeBracket[s] == "(" { continue } else { return false }
    }
    
    return true
}

print(isProperly("(()())"))
print(isProperly("()())"))

// MARK: - დავალება 5

func countVariants(_ stairsCount: Int) -> Int {

    if stairsCount == 1 || stairsCount == 0 { return 1 }
    if stairsCount == 2 { return 2 }
    
    return countVariants(stairsCount - 2) + countVariants(stairsCount - 1)
}

print(countVariants(6))

// MARK: - დავალება 6

class DataStruct {
    
    private var myData: [String]
    
    init(myData: [String]) {
        
        self.myData = myData
    }
    
    func deleteElement(_ element: Int) {
        
        if myData.indices.contains(element) {
            
            myData.remove(at: element)
            print("Element has been deleted")
            
        } else {
            
            print("Error")
        }
    }
}

var test = DataStruct(myData: ["lavander", "George", "salmon", "hill"])
test.deleteElement(2)
