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
    
    //MARK: Data In
    let matches: [Match]
    
    // MARK: - Body
    var body: some View {
        // Create a compact, square-ish grid of markers based on the number of matches
        let count = matches.count
        let columns = Int(ceil(sqrt(Double(max(count, 1)))))
        let rows = Int(ceil(Double(count) / Double(columns)))
        VStack(spacing: 4) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(0..<columns, id: \.self) { col in
                        let index = row * columns + col
                        if index < count {
                            matchMaker(peg: index)
                        } else {
                            // Fillers to keep grid shape
                            Circle()
                                .fill(Color.clear)
                                .overlay(Circle().stroke(Color.clear))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
    
    func matchMaker(peg: Int) -> some View {
        let isExact = (peg < matches.count) && (matches[peg] == .exact)
        let isFound = (peg < matches.count) && (matches[peg] != .nomatch)
        return Circle()
            .fill(isExact ? Color.primary : Color.clear)
            .strokeBorder(isFound ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
    
}


#Preview {
    VStack {
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact, .inexact, .nomatch])
    }
    .padding()
}
