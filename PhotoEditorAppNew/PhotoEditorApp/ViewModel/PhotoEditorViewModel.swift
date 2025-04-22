//
//  PhotoEditorViewModel.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

@MainActor  // Marking the class as main-actor isolated
class PhotoEditorViewModel: ObservableObject {
    @Published var image: UIImage? = nil  // Original image
    @Published var processedImage: UIImage? = nil  // Processed image after adjustments

    @Published var isPickerPresented = false

    // Adjustment properties
    @Published var exposure: Float = 0 { didSet
        {print("Exposure value changed: \(exposure)")
            applyAdjustments() } }
    @Published var brilliance: Float = 0 { didSet {
        print("Brilliance value changed: \(brilliance)")
        applyAdjustments() } }
    @Published var highlights: Float = 0 { didSet { applyAdjustments() } }
    @Published var shadows: Float = 0 { didSet { applyAdjustments() } }
    @Published var contrast: Float = 0 { didSet { applyAdjustments() } }
    @Published var brightness: Float = 0 { didSet { applyAdjustments() } }
    @Published var blackPoint: Float = 0 { didSet { applyAdjustments() } }
    @Published var saturation: Float = 0 { didSet { applyAdjustments() } }
    @Published var vibrance: Float = 0 { didSet { applyAdjustments() } }
    @Published var warmth: Float = 0 { didSet { applyAdjustments() } }
    @Published var tint: Float = 0 { didSet { applyAdjustments() } }

    private let context = CIContext()

    
    func applyAdjustments() {
        print("applyAdjustments called")  // This should print whenever sliders are moved
        
        guard let inputImage = image,
//                let ciImage = CIImage(image: inputImage)
              let ciImage = CIImage(image: inputImage)?.oriented(forExifOrientation: Int32(inputImage.imageOrientation.rawValue))
        else { return }
        
        // Ensure the UIImage orientation is respected when converting to CIImage
         

        
        var workingImage: CIImage? = ciImage
        
        // Apply exposure adjustment
        if exposure != 0 {
            
            
            let exposureFilter = CIFilter.exposureAdjust()
            exposureFilter.inputImage = workingImage
            exposureFilter.ev = exposure / 100
            workingImage = exposureFilter.outputImage
            
            print("Exposure applied: \(exposure)")  // Confirm exposure adjustment
            
            // Print statement to confirm that workingImage is valid
            
            print("Exposure adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
            
        }
        
        // Apply brilliance (using shadow adjustment to mimic brilliance)
        if brilliance != 0 {
            
            let brillianceFilter = CIFilter.highlightShadowAdjust()
            brillianceFilter.inputImage = workingImage
            brillianceFilter.shadowAmount = brilliance / 100
            workingImage = brillianceFilter.outputImage
            
            print("Brilliance applied: \(brilliance)")  // Confirm brilliance adjustment
            
            print("Brilliance adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
        }
        
                // Apply highlights adjustment
                if highlights != 0 {
                    let highlightsFilter = CIFilter.highlightShadowAdjust()
                    highlightsFilter.inputImage = workingImage
                    highlightsFilter.highlightAmount = highlights / 100
                    workingImage = highlightsFilter.outputImage
                    print("Highlights adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
        
                }
        
                // Apply shadows adjustment
                if shadows != 0 {
                    let shadowsFilter = CIFilter.highlightShadowAdjust()
                    shadowsFilter.inputImage = workingImage
                    shadowsFilter.shadowAmount = shadows / 100
                    workingImage = shadowsFilter.outputImage
                    print("Shadows adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
        
                }
        
                // Apply contrast adjustment
                if contrast != 0 {
                    let contrastFilter = CIFilter.colorControls()
                    contrastFilter.inputImage = workingImage
                    contrastFilter.contrast = contrast / 100
                    workingImage = contrastFilter.outputImage
                    print("Contrast adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
              
                }
        
                // Apply brightness adjustment
                if brightness != 0 {
                    let brightnessFilter = CIFilter.colorControls()
                    brightnessFilter.inputImage = workingImage
                    brightnessFilter.brightness = brightness / 100
                    workingImage = brightnessFilter.outputImage
                    print("Brightness adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
        
                }
        
                // Apply black point adjustment
                if blackPoint != 0 {
                    let blackPointFilter = CIFilter.colorControls()
                    blackPointFilter.inputImage = workingImage
                    blackPointFilter.brightness = blackPoint * -1 / 100 // Inverse brightness to simulate black point
                    workingImage = blackPointFilter.outputImage
                    print("Black Point adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
              
                }
        
                // Apply saturation adjustment
                if saturation != 0 {
                    let saturationFilter = CIFilter.colorControls()
                    saturationFilter.inputImage = workingImage
                    saturationFilter.saturation = saturation / 100
                    workingImage = saturationFilter.outputImage
                    print("Saturation adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
              
                }
        
                // Apply vibrance adjustment
                if vibrance != 0 {
                    let vibranceFilter = CIFilter.vibrance()
                    vibranceFilter.inputImage = workingImage
                    vibranceFilter.amount = vibrance / 100
                    workingImage = vibranceFilter.outputImage
                    print("Vibrance adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
        
                }
        
                // Apply warmth adjustment
                if warmth != 0 {
                    let warmthFilter = CIFilter.temperatureAndTint()
                    warmthFilter.inputImage = workingImage
                    warmthFilter.neutral = CIVector(x: CGFloat(warmth), y: 0) // Use x for warmth
                    workingImage = warmthFilter.outputImage
                    print("Warmth adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
              
                }
        
                // Apply tint adjustment
                if tint != 0 {
                    let tintFilter = CIFilter.temperatureAndTint()
                    tintFilter.inputImage = workingImage
                    tintFilter.targetNeutral = CIVector(x: CGFloat(tint), y: 0) // Use x for tint
                    workingImage = tintFilter.outputImage
                    print("Tint adjustment applied, workingImage size: \(workingImage?.extent.size ?? CGSize.zero)")
                }
        
//         Final output image from all filters
//        if let outputImage = workingImage?.transformed(by: CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -workingImage!.extent.height))
        
            guard let outputImage = workingImage else { return }
            
            
            if let cgImage = context.createCGImage(workingImage ?? ciImage, from: workingImage?.extent ?? ciImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    self.processedImage = uiImage
                    print("CGImage created successfully with size: \(cgImage.width)x\(cgImage.height)")
                    //                print("UIImage created successfully with size: \(uiImage.size)")
                    print("processed image created successfully with size: \(String(describing: self.processedImage?.size))")
                }
            } else {
                print("Failed to create CGImage")
            }
            
        }
    


    func applyFilter(_ filter: PhotoFilter) {
        switch filter {
       case .vivid:
           applyVividFilter()
       case .vividWarm:
            applyVividWarmFilter()
        }
  }

   func applyVividFilter() {
      contrast = 30
      saturation = 50
      applyAdjustments()
   }

    func applyVividWarmFilter() {
        warmth = 30
        contrast = 40
        saturation = 60
        applyAdjustments()
    }

   func checkPhotoLibraryPermission() {
        // Handle photo library permission logic here
    }
}
