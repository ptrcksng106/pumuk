//
//  GameplayViewModel.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI
import Combine

final class GameplayViewModel: ObservableObject {
    @Published var mosquitoes: [Mosquito] = []
    @Published var score: Int = 0
    @Published var timeRemaining: Int = 60
    @Published var isGameOver: Bool = false
    
    private var mosquitoTimer: AnyCancellable?
    private var countdownTimer: AnyCancellable?
    
    func startGame(in size: CGSize) {
        isGameOver = false
        spawnMosquito(in: size)
        
        mosquitoTimer = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.respawnMosquito(in: size)
            }
        
        countdownTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    stopGame()
                    isGameOver = true
                }
            }
    }
    
    func stopGame() {
        mosquitoTimer?.cancel()
        countdownTimer?.cancel()
    }
    
    private func respawnMosquito(in size: CGSize) {
        withAnimation {
            mosquitoes.removeAll()
        }
        spawnMosquito(in: size)
    }
    
    func spawnMosquito(in size: CGSize) {
        let x = CGFloat.random(in: 50...size.height - 50)
        let y = CGFloat.random(in: 100...size.width - 100)
        
        withAnimation {
            mosquitoes.append(Mosquito(position: CGPoint(x: x, y: y)))
        }
    }
    
    func checkHit(at hand: CGPoint, in size: CGSize) {
        let convertedHand = CGPoint(x: hand.x * size.width, y: hand.y * size.height)
        
        for mosquito in mosquitoes {
            let distance = hypot(mosquito.position.x - convertedHand.x,
                                 mosquito.position.y - convertedHand.y)
            if distance < 100 {
                withAnimation(.spring()) {
                    mosquitoes.removeAll { $0.id == mosquito.id }
                    score += 1
                }
                break
            }
        }
    }
}
