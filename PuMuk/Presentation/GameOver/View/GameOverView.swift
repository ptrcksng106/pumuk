//
//  GameOverView.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

struct GameOverView: View {
    let score: String
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack {
                    Text("Game Over")
                        .foregroundStyle(.greenPrimary)
                        .font(.game(size: 64))
                        .multilineTextAlignment(.center)
                    
                    Text("Your Score: \(score)")
                        .foregroundStyle(.black)
                        .font(.game(size: 40))
                        .multilineTextAlignment(.center)
                }
                
                PrimaryButton(title: "Play Again")
                    .padding(.top, 14)
                    .onTapGesture {
                        router.popToView(count: 1)
                    }
                
                PrimaryButton(title: "Home", color: .white)
                    .onTapGesture {
                        router.navigateToRoot()
                    }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameOverView(score: "100")
}
