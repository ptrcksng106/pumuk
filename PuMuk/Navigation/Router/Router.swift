//
//  Router.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func popToView(count: Int) {
        path.removeLast(count)
    }
}

extension Router {
    func canNavigateBack() -> Bool {
        return path.count > 0
    }
}
