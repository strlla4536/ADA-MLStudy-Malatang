//
//  Detecter.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/30/24.
//

import AVFoundation
import Vision

class Detecter: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let modelManager: MLModelManager?

    // 초기화 메서드
    override init() { // override 키워드 추가
        self.modelManager = MLModelManager() // 옵셔널 처리
        super.init() // 상위 클래스의 초기화 메서드 호출
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let modelManager = modelManager else {
            print("Model Manager is nil.")
            return
        }
        
        modelManager.classifyAction(in: sampleBuffer) { score in
            DispatchQueue.main.async {
                // 점수를 처리하는 로직을 여기에 추가하세요
                print("인식한 점수: \(score)")
            }
        }
    }
}
