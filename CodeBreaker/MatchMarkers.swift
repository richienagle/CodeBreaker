//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Rich Nagle on 12/30/25.
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View {
    var matches: [Match]
    
    var body : some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        // get how many times .exact appears
        // matches.count takes a function
        // func isExact(match: Match) -> Bool {
        //    match == .exact
        // }
        //let exactCount = matches.count(where: isExact)
        // $0 is the first arguement
        //let exactCount: Int = matches.count(where: { match in match == .exact})
        
        let exactCount = matches.count { $0 == .exact}
        let foundCount = matches.count { $0 != .nomatch}
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)  //ternary poerator
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchMarkers(matches:[.exact, .inexact, .inexact, .nomatch])
}
