//
//  GameplayView.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

struct GameplayView: View {
    @StateObject private var viewModel: GameplayViewModel = GameplayViewModel()
    @StateObject private var handHitManager: HandHitManager = HandHitManager()
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                CameraViewRepresentable(handManager: handHitManager)
                    .ignoresSafeArea()
                
                ForEach(viewModel.mosquitoes, id: \.self) { mosquito in
                    Image(.moquito)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .position(mosquito.position)
                }
                
                VStack {
                    ZStack {
                        Text("\(viewModel.timeRemaining)")
                            .foregroundStyle(.greenPrimary)
                            .font(.game(size: 40))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Score: \(viewModel.score)")
                            .foregroundStyle(.yellowPrimary)
                            .font(.game(size: 40))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
            }
            .onAppear {
                AppDelegate.orientationLock = .landscape
                viewModel.startGame(in: geo.size)
            }
            .onChange(of: handHitManager.handPosition) { pos in
                guard let pos = pos else { return }
                viewModel.checkHit(at: pos, in: geo.size)
            }
            .onChange(of: viewModel.isGameOver) { isGameover in
                guard isGameover else { return }
                router.navigate(to: .gameover(score: String(viewModel.score)))
            }
        }
        .navigationBarBackButtonHidden()
        .onDisappear {
            viewModel.stopGame()
            AppDelegate.orientationLock = .portrait
        }
    }
}

#Preview {
    GameplayView()
        .environmentObject(Router())
}
