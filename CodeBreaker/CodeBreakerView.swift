//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by benjamin on 7/6/26.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game =  CodeBreaker(pegChoices: [.blue, .red, .green, .yellow], pegCount: 5)
    @State private var selection: Int = 0
    
    // MARK: - Body
    
    var body: some View {
        VStack {

            view(for: game.masterCode)
            ScrollView() {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            pegChooser
            resetButton
        }
        .padding()
    }
    
    var resetButton: some View {
        Button("Restart") {
            withAnimation {
                let choices = game.pegChoices
                let count = Int.random(in: 3...6)
                game = CodeBreaker(pegChoices: choices, pegCount: count)
            }
        }
        .foregroundColor(.white)
        .font(.title)
        .buttonStyle(.glassProminent)
    }
    
    var pegChooser: some View {
        HStack {
            ForEach(game.pegChoices, id: \.self) { peg in
                Button {
                    game.setGuessPeg(peg, at: selection)
                    selection = (selection + 1) % game.pegCount
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(Array(code.pegs.indices), id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background(selectionBackground(isSelected: selection == index && code.kind == .guess))
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Rectangle().foregroundStyle(Color.clear).aspectRatio(contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matches: matches)
                    } else {
                        if code.kind == .guess {
                            guessButton
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private func selectionBackground(isSelected: Bool) -> some View {
        if isSelected {
            RoundedRectangle(cornerRadius: Selection.cornerRadius)
                .foregroundStyle(Selection.color)
        } else {
            Color.clear
        }
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    struct Selection {
        static let border: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}

