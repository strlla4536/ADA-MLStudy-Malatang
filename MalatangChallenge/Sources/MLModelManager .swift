//
//  MLModelManager .swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/30/24.
//

import CoreML
import Vision
import AVFoundation

class MLModelManager {
    private let model: VNCoreMLModel
    private let confidenceThreshold: Float = 0.5 // 결과 필터링에 사용될 최소 confidence 값
    
    init?() {
        // Core ML 모델을 Vision 모델로 변환
        guard let model = try? VNCoreMLModel(for: Malatang().model) else {
            print("모델을 로드할 수 없습니다.")
            return nil
        }
        self.model = model
    }
    
    func classifyAction(in sampleBuffer: CMSampleBuffer, completion: @escaping (Float?) -> Void) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            completion(nil)
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let bestResult = results.first,
               bestResult.confidence >= self.confidenceThreshold {
                completion(bestResult.confidence)
            } else {
                completion(nil)
            }
        }
        
        // 요청에 대한 핸들러 설정
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("ML 모델 요청을 수행하는 데 실패했습니다: \(error)")
            completion(nil)
        }
    }
}
