//
//  GrainAndScratchFilter.swift
//  PolaroidEffectAppToo
//
//  Created by amber on 10/18/24.
//


import UIKit
import CoreImage

class GrainAndScratchFilter {
    static func apply(to image: UIImage, grainIntensity: Float, scratchIntensity: Float) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let context = CIContext(options: nil)
        
        // Create random noise for grain
        let grainFilter = CIFilter(name: "CIRandomGenerator")!
        let noiseImage = grainFilter.outputImage!.cropped(to: ciImage.extent)
        
        // Apply grain effect by adjusting color components
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x: 0, y: 0.005, z: 0, w: 0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        let whiteningFilter = CIFilter(name: "CIColorMatrix")!
        whiteningFilter.setValue(noiseImage, forKey: kCIInputImageKey)
        whiteningFilter.setValue(whitenVector, forKey: "inputRVector")
        whiteningFilter.setValue(whitenVector, forKey: "inputGVector")
        whiteningFilter.setValue(whitenVector, forKey: "inputBVector")
        whiteningFilter.setValue(fineGrain, forKey: "inputAVector")
        whiteningFilter.setValue(zeroVector, forKey: "inputBiasVector")
        
        guard let whiteSpecks = whiteningFilter.outputImage else { return nil }
        
        // Composite grain onto the original image
        let speckCompositor = CIFilter(name: "CISourceOverCompositing")!
        speckCompositor.setValue(whiteSpecks, forKey: kCIInputImageKey)
        speckCompositor.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        guard let speckledImage = speckCompositor.outputImage else { return nil }
        
        // Create scratches by transforming random noise
        let scratchNoise = noiseImage.transformed(by: CGAffineTransform(scaleX: 1.5, y: 25))
        
        let darkenVector = CIVector(x: 4, y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: 1, z: 1, w: 1)
        
        let scratchFilter = CIFilter(name: "CIColorMatrix")!
        scratchFilter.setValue(scratchNoise, forKey: kCIInputImageKey)
        scratchFilter.setValue(darkenVector, forKey: "inputRVector")
        scratchFilter.setValue(zeroVector, forKey: "inputGVector")
        scratchFilter.setValue(zeroVector, forKey: "inputBVector")
        scratchFilter.setValue(zeroVector, forKey: "inputAVector")
        scratchFilter.setValue(darkenBias, forKey: "inputBiasVector")
        
        guard let randomScratches = scratchFilter.outputImage else { return nil }
        
        // Convert scratches to grayscale
        let grayscaleFilter = CIFilter(name: "CIMinimumComponent")!
        grayscaleFilter.setValue(randomScratches, forKey: kCIInputImageKey)
        
        guard let darkScratches = grayscaleFilter.outputImage else { return nil }
        
        // Composite scratches multiplicatively
        let oldFilmCompositor = CIFilter(name: "CIMultiplyCompositing")!
        oldFilmCompositor.setValue(darkScratches, forKey: kCIInputImageKey)
        oldFilmCompositor.setValue(speckledImage, forKey: kCIInputBackgroundImageKey)
        
        guard let oldFilmImage = oldFilmCompositor.outputImage else { return nil }
        
        // Crop the result to the original image extent
        let finalImage = oldFilmImage.cropped(to: ciImage.extent)
        
        // Render the final image
        guard let outputCGImage = context.createCGImage(finalImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: outputCGImage)
    }
}
