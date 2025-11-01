//
//  DashboardView.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Pumuk")
                    .foregroundStyle(.greenPrimary)
                    .font(.game(size: 96))
                
                HStack(spacing: 16) {
                    Image(.person)
                    
                    Text("VS")
                        .foregroundStyle(.yellowPrimary)
                        .font(.game(size: 48))
                    
                    Image(.moquito)
                }
                .padding(.horizontal, 16)
                
                PrimaryButton(title: "Start")
                    .padding(.horizontal, 50)
                    .onTapGesture {
                        router.navigate(to: .gameplay)
                    }
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(Router())
}
