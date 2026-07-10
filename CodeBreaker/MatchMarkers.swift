//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by benjamin on 7/8/26.
//
import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View {
    var matches: [Match]
    
    var body: some View {
        VStack {
            HStack {
                matchMaker(peg: 0)
                matchMaker(peg: 1)
            }
            HStack {
                matchMaker(peg: 2)
                matchMaker(peg: 3)
            }
        }
    }
    
    func matchMaker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact}
                                    // { (match: Match) -> Bool in match == .exact
                                    // (where: {match in match == .exact})
                                    // (where: ($0 == .exact)}
        let foundCount = matches.count { $0 != .nomatch}
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth:2).aspectRatio(1, contentMode: .fit)
    }
    
}


#Preview {
    MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
}
