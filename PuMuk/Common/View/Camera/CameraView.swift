//
//  CameraView.swift
//  PuMuk
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 01/11/25.
//

import AVFoundation
import UIKit

class CameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var captureSession: AVCaptureSession?
    private var handHitManager: HandHitManager?
    private var videoOutput = AVCaptureVideoDataOutput()
    
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    private var previewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    func startSession(with handHitManager: HandHitManager) {
        self.handHitManager = handHitManager
        
        let session = AVCaptureSession()
        session.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: device)
        else { return }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "CameraQueue"))
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        previewLayer.connection?.isVideoMirrored = true
        previewLayer.connection?.videoOrientation = .landscapeRight
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
        
        captureSession = session
    }
    
    func stopSession() {
        captureSession?.stopRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        handHitManager?.processSampleBuffer(sampleBuffer)
    }
}
