//
//  PrimaryButton.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var color: Color = .black
    
    var body: some View {
        Text(title)
            .font(.game(size: 40))
            .foregroundStyle(color)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .frame(height: 66)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.yellowPrimary)
            )
    }
}

#Preview {
    PrimaryButton(title: "VS")
}
