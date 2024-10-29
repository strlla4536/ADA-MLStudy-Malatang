//
//  Score.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/30/24.
//

import Foundation
import AVFoundation

class Score {
    private let modelManager: MLModelManager?
    
    init() {
        self.modelManager = MLModelManager()
    }
    
    func calculateScore(from sampleBuffer: CMSampleBuffer, completion: @escaping (Int) -> Void) {
        guard let modelManager = modelManager else {
            completion(0) // 모델이 초기화되지 않은 경우 기본 점수 반환
            return
        }
        
        modelManager.classifyAction(in: sampleBuffer) { score in
            completion(score)
        }
    }
}
