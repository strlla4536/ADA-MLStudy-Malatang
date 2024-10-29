//
//  Coordinator.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/30/24.
//

import AVFoundation

class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let modelManager: MLModelManager? // 옵셔널로 선언
    private let scoreHandler: (Int) -> Void
    
    init(modelManager: MLModelManager, scoreHandler: @escaping (Int) -> Void) {
        self.modelManager = modelManager
        self.scoreHandler = scoreHandler
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // modelManager가 nil인지 확인하고 안전하게 언랩핑
        guard let modelManager = modelManager else {
            print("Model Manager is nil.")
            return
        }
        
        modelManager.classifyAction(in: sampleBuffer) { score in
            DispatchQueue.main.async {
                self.scoreHandler(score)
            }
        }
    }
}

