//
//  HandHitManager.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import Combine
import Vision
import SwiftUI

final class HandHitManager: ObservableObject {
    @Published var handPosition: CGPoint?
    
    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    func processSampleBuffer(_ sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
        do {
            try handler.perform([self.handPoseRequest])
            guard let result = self.handPoseRequest.results?.first else { return }
            
            let wrist = try? result.recognizedPoint(.wrist)
            let indexMCP = try? result.recognizedPoint(.indexMCP)
            let middleMCP = try? result.recognizedPoint(.middleMCP)
            let littleMCP = try? result.recognizedPoint(.littleMCP)
            
            print("--- wrist: \(wrist)")
            print("--- indexMCP: \(indexMCP)")
            print("--- middleMCP: \(middleMCP)")
            print("--- littleMCP: \(littleMCP)")
            
            let points = [wrist, indexMCP, middleMCP, littleMCP].compactMap { $0?.confidence ?? 0.0 > 0.5 ? $0 : nil
            }
            
            guard points.count > 1 else { return }
            
            let avgX = points.map { $0.location.x }.reduce(0, +) / CGFloat(points.count)
            let avgY = points.map { $0.location.y }.reduce(0, +) / CGFloat(points.count)
            
            DispatchQueue.main.async {
                self.handPosition = CGPoint(x: avgX, y: 1 - avgY)
            }
        } catch {
            print("--- error: \(error)")
        }
    }
}
