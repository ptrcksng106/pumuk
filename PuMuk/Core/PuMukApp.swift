//
//  PuMukApp.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

@main
struct PuMukApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                DashboardView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .gameplay:
                            GameplayView()
                        case .gameover(let score):
                            GameOverView(score: score)
                        default:
                            EmptyView()
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
