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
    private let model: VNCoreMLModel?

    init() {
        let configuration = MLModelConfiguration()
        
        // 모델 초기화가 실패하면 nil로 설정
        self.model = try? VNCoreMLModel(for: Malatang(configuration: configuration).model)
    }

    func classifyAction(in sampleBuffer: CMSampleBuffer, completion: @escaping (Int) -> Void) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            completion(0)
            return
        }

        // 모델이 nil일 경우 기본 점수 반환
        guard let model = model else {
            completion(0)
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                completion(0)
                return
            }
            let score = self.calculateScore(from: results)
            completion(score)
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }

    private func calculateScore(from results: [VNClassificationObservation]) -> Int {
        let confidences = results
            .filter { $0.identifier != "None" }
            .map { $0.confidence }

        guard !confidences.isEmpty else { return 0 }

        let averageConfidence = confidences.reduce(0, +) / Float(confidences.count)
        return Int(averageConfidence * 100)
    }
}
