//
//  CameraViewRepresentable.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import SwiftUI
import AVFoundation

struct CameraViewRepresentable: UIViewRepresentable {
    var handManager: HandHitManager
    
    func makeUIView(context: Context) -> CameraView {
        let cameraView = CameraView()
        cameraView.startSession(with: handManager)
        return cameraView
    }
    
    func updateUIView(_ uiView: CameraView, context: Context) {
        
    }
}

