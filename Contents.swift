import UIKit

/*
 # Given the following quote by Alan Perlis

“Dealing with failure is easy: Work hard to improve. Success is also easy to
handle: You’ve solved the wrong problem. Work hard to improve.”

Considering only the alphabetical characters, consonants having the value of
their ASCII codes, and vowels having the inverse value of their ASCII codes,
what is the sum of the sentence?

Example:
Using the phrase “why and how”, w=119, h=104, y=121, d=100, n=110. A and O are vowels, so a=-97 o=-111. The sum of ‘why and how’ = 569.
 */

// ## Set Up

let invalidChars: [Character] = [" ", ":", ".", "'"]

let vowels: [Character] = [
    "A", "a",
    "E", "e",
    "I", "i",
    "O", "o",
    "U", "u"
]

// 569
let whyHow = "why:.and how"

// 2865
let alanQuote = "Dealing with failure is easy: Work hard to improve. Success is also easy to handle: You've solved the wrong problem. Work hard to improve."


// ## Solution Iterative

func solutionIterative(_ input: String) -> Int {
    var validCharsOnly = ""
    
    input.forEach { char in
        guard !invalidChars.contains(char) else { return }
        validCharsOnly.append(char)
    }
    
    var asciiValues: [Int] = []
    
    validCharsOnly.forEach { char in
        let asciiValue = vowels.contains(char)
            ? 0 - Int(char.asciiValue!)
            : Int(char.asciiValue!)
        asciiValues.append(asciiValue)
    }
    
    var sum = 0
    
    asciiValues.forEach { value in sum += value }
    
    return sum
}



// ### Iterative Slow Counting

var solutionIterativeFilterCount = 0
var solutionIterativeMapCount    = 0
var solutionIterativeReduceCount = 0


func solutionIterativeCounting(_ input: String) -> Int {
    var validCharsOnly = ""
    
    input.forEach { char in
        solutionIterativeFilterCount += 1
        guard !invalidChars.contains(char) else { return }
        validCharsOnly.append(char)
    }
    
    var asciiValues: [Int] = []
    
    validCharsOnly.forEach { char in
        solutionIterativeMapCount += 1
        let asciiValue = vowels.contains(char)
            ? 0 - Int(char.asciiValue!)
            : Int(char.asciiValue!)
        asciiValues.append(asciiValue)
    }
    
    var sum = 0
    
    asciiValues.forEach { v in
        solutionIterativeReduceCount += 1
        sum += v
    }
    
    return sum
}


//solutionIterativeCounting(whyHow)
solutionIterativeCounting(alanQuote)

print("Iterative Slow --")
print("filter count:      ", solutionIterativeFilterCount)
print("map count:         ", solutionIterativeMapCount)
print("reduce count:      ", solutionIterativeReduceCount)
print("total interations: ", solutionIterativeFilterCount + solutionIterativeMapCount + solutionIterativeReduceCount)










/// Functional Slow Readable



func solutionFunctionalSlow(_ input: String) -> Int {
    return input
        .filter { !invalidChars.contains($0) }
        .map { char in
            return vowels.contains(char)
                ? 0 - Int(char.asciiValue!)
                : Int(char.asciiValue!)
        }
        .reduce(0) { $0 + $1 }
}




solutionFunctionalSlow(whyHow)
solutionFunctionalSlow(alanQuote)


// ###### Counting Slow


var solutionFunctionalFilterCount = 0
var solutionFunctionalMapCount    = 0
var solutionFunctionalReduceCount = 0

func solutionFunctionalSlowCounting(_ input: String) -> Int {
    let filtered = input.filter {
        solutionFunctionalFilterCount += 1
        return !invalidChars.contains($0)
    }
    
    let asciiValues: [Int] = filtered.map { c in
        solutionFunctionalMapCount += 1
        return vowels.contains(c)
            ? 0 - Int(c.asciiValue!)
            : Int(c.asciiValue!)
    }
    
    return asciiValues.reduce(0) {
        solutionFunctionalReduceCount += 1
        return $0 + $1
    }
}


//solutionFunctionalSlowCounting(whyHow)
solutionFunctionalSlowCounting(alanQuote)

print("\n\nFunctional Slow --")
print("filter count:     ", solutionFunctionalFilterCount)
print("map count:        ", solutionFunctionalMapCount)
print("reduce count:     ", solutionFunctionalReduceCount)
print("total iterations: ", solutionFunctionalFilterCount + solutionFunctionalMapCount + solutionFunctionalReduceCount)











var solutionFunctionalSemiFastFilterMapCount = 0
var solutionFunctionalSemiFastReduceCount = 0


func filterMapCharacter(char: Character) -> Int? {
    solutionFunctionalSemiFastFilterMapCount += 1
    guard !invalidChars.contains(char) else { return nil }
    return vowels.contains(char)
        ? 0 - Int(char.asciiValue!)
        : Int(char.asciiValue!)
}



// Soltion Semi Fast


func solutionFunctionalSemiFast(_ input: String) -> Int {
    return input
        .compactMap(filterMapCharacter)
        .reduce(0) {
            solutionFunctionalSemiFastReduceCount += 1
            return $0 + $1
        }
}


//solutionFunctionalSemiFast(whyHow)
solutionFunctionalSemiFast(alanQuote)

print("\n\nFunctional Semi Fast")
print("filterMap count:  ", solutionFunctionalSemiFastFilterMapCount)
print("reduce count:     ", solutionFunctionalSemiFastReduceCount)
print("total iterations: ", solutionFunctionalSemiFastFilterMapCount + solutionFunctionalSemiFastReduceCount)




















func filterMapCharactersClean(char: Character) -> Int? {
    return shouldNotRemove(char)
        ? asciiValue(for: char)
        : nil
}


func shouldNotRemove(_ char: Character) -> Bool {
    return !invalidChars.contains(char)
}

func asciiValue(for char: Character) -> Int {
    return vowels.contains(char)
        ? 0 - Int(char.asciiValue!)
        : Int(char.asciiValue!)
}



func solutionSemiFastClean(_ input: String) -> Int {
    return input
        .compactMap(filterMapCharactersClean)
        .reduce(0, +)
}


solutionSemiFastClean(whyHow)
solutionSemiFastClean(alanQuote)






func filterMap<A, B>(default d: B? = nil, predicate p: @escaping (A) -> Bool, function f: @escaping (A) -> B) -> ((A) -> B?) {
    return { a in
        p(a) ? f(a) : d
    }
}



let filterMapChar = filterMap(default: 1, predicate: shouldNotRemove, function: asciiValue)


func solutionFilterMapGeneric(_ input: String) -> Int {
    return input
        .compactMap(filterMapChar)
        .reduce(0, +)
}



solutionFilterMapGeneric(whyHow)
solutionFilterMapGeneric(alanQuote)




var solutionFilterMapGenericIterativeCount = 0

func solutionFilterMapGenericIterative(_ input: String) -> Int {
    var sum = 0
    input.forEach { char in
        solutionFilterMapGenericIterativeCount += 1
        guard let foo = filterMapChar(char) else { return }
        sum += foo
    }
    
    return sum
}

//solutionFilterMapGenericIterative(whyHow)
solutionFilterMapGenericIterative(alanQuote)

print("\n\nGeneric Iterative --")
print("generic interative: ", solutionFilterMapGenericIterativeCount)
print("Alan Quote Count: ", alanQuote.count)


func solutionFilterMapGenericReduce(_ input: String) -> Int {
    input.reduce(0) { result, char in
        guard let asciiValue = filterMapChar(char) else { return result }
        return result + asciiValue
    }
}


solutionFilterMapGenericReduce(whyHow)
solutionFilterMapGenericReduce(alanQuote)




extension Collection {
    func compactReduce<Result>(_ initialResult: Result, _ f: (Self.Element) -> Result?, _ combine: (Result, Result) -> Result) -> Result {
        return self.reduce(initialResult) { res, el -> Result in
            guard let next = f(el) else { return res }
            return combine(next, res)
        }
    }
}

//whyHow.compactReduce(0, filterMapChar, +)
alanQuote.compactReduce(0, filterMapChar, +)

func finalSolution(_ input: String) -> Int {
    return input.compactReduce(0, filterMap(predicate: shouldNotRemove, function: asciiValue), +)
}

finalSolution(alanQuote)














func functor<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}






let example1 = [1, 2, 3, 4, 5, 6]

print(example1.map { $0 + 10 }.map { $0 * 10 })

//let addTen: ((Int) -> Int) = { $0 + 10 }
//let multTen: ((Int) -> Int) = { $0 * 10 }

func addTen(_ x: Int) -> Int { return x + 10 }
func mulTen(_ x: Int) -> Int { return x * 10 }

let addMult = functor(addTen, mulTen)

example1.map(addMult)

infix operator <^>

func <^><A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> ((A) -> C) {
    return functor(f, g)
}

example1.map(addTen <^> mulTen)
