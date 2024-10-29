//
//  CameraView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    private let captureSession = AVCaptureSession()
    private let cameraPosition: AVCaptureDevice.Position
    private let detecter: Detecter // Detecter 인스턴스 추가
    
    init(cameraPosition: AVCaptureDevice.Position, detecter: Detecter) {
        self.cameraPosition = cameraPosition
        self.detecter = detecter // detecter 초기화
        configureCaptureSession()
    }

    func makeUIView(context: Context) -> UIView {
        let view = PreviewView()
        
        if let previewLayer = view.previewLayer {
            previewLayer.session = captureSession
            previewLayer.videoGravity = .resizeAspectFill
        }
        
        requestCameraPermission()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No need to update UI for this use case
    }
    
    private func requestCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    startSession()
                } else {
                    print("카메라 사용 권한이 거부되었습니다.")
                }
            }
        case .authorized:
            startSession()
        default:
            print("카메라 사용 권한이 필요합니다.")
        }
    }
    
    private func startSession() {
        DispatchQueue.main.async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }
    
    private func configureCaptureSession() {
        captureSession.beginConfiguration()
        
        guard let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition),
              let videoInput = try? AVCaptureDeviceInput(device: cameraDevice) else {
            print("카메라 장치를 사용할 수 없습니다.")
            captureSession.commitConfiguration()
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(detecter, queue: DispatchQueue(label: "cameraQueue")) // Detecter를 delegate로 설정
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.commitConfiguration()
    }
}

fileprivate class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var previewLayer: AVCaptureVideoPreviewLayer? {
        return layer as? AVCaptureVideoPreviewLayer
    }
}


#Preview {
    CameraView(cameraPosition: .front, detecter: Detecter())
}

