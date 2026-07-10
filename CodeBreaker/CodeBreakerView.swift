//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by benjamin on 7/6/26.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game =  CodeBreaker(pegChoices: [.blue, .red, .green, .yellow])
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView() {
                
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }

            //pegs(colors: game.attempts.last?.pegs ?? [])
        }
        .padding()
    }
    
    var guessButtion: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.01)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButtion
                    }
                }
        }
    }
}

#Preview {
    CodeBreakerView()
}
