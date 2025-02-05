//
//  CameraViewController.swift
//  NumberGussr
//
//  Created by Mathieu Ponal on 05/02/2025.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureOutput: AVCapturePhotoOutput!
    
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No back camera available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            // Output for capturing photos
            captureOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(captureOutput) {
                captureSession.addOutput(captureOutput)
            }
            
            // Setup the preview layer
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = previewView.bounds
            previewView.layer.addSublayer(previewLayer)

            
            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = previewView.bounds
    }

    
    @IBAction func capturePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        captureOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
}
