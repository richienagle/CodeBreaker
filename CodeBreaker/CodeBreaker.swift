//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by benjamin on 7/10/26.
//

//import Foundation
import SwiftUI

typealias Peg = Color

extension Peg {
    static let missing = Color.clear
}

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master(isHidden: true), pegCount: 4)
    var guess: Code
    var attempts: [Code] = []
    let pegChoices: [Peg]       //the set of allowed choices for the game
    let pegCount: Int
    
    init(pegChoices: [Peg]?, pegCount: Int = 4) {
        let count = max(3, min(pegCount, 6))
        self.pegCount = count
        let defaults: [Peg] = [.blue, .red, .green, .yellow]
        let choices = pegChoices ?? defaults
        self.pegChoices = choices
        masterCode = Code(kind: .master(isHidden: true), pegCount: count)
        guess = Code(kind: .guess, pegCount: count)
        masterCode.randomize(from: choices)
        //print(masterCode)
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}


    //
    //      *** Original ***
    //
    //      func match(against otherCode: Code) -> [Match] {

    //         var results: [Match] = Array(repeating: .nomatch, count: pegs.count)

    //        //Pass 1: Exact matches
    //        for index in pegs.indices.reversed() {
    //            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
    //                results[index] = .exact
    //                pegsToMatch.remove(at: index)
    //            }
    //        }
    //        //Pass 2: Inexact matches
    //        for index in pegs.indices {
    //            if results[index] != .exact {
    //                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
    //                    results[index] = .inexact
    //                    pegsToMatch.remove(at: matchIndex)
    //                }
    //            }
    //        }
    //        return results
    //    }
    
