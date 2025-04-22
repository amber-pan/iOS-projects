//
//  PhotoAdjustments.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct PhotoAdjustments {
    let context = CIContext()
    
    // Apply exposure adjustment
    func adjustExposure(image: CIImage, exposure: Float) -> CIImage? {
        let filter = CIFilter.exposureAdjust()
        filter.inputImage = image
        filter.ev = exposure
        return filter.outputImage
    }
    
    // Apply brilliance adjustment
    func adjustBrilliance(image: CIImage, brilliance: Float) -> CIImage? {
        let filter = CIFilter.highlightShadowAdjust()
        filter.inputImage = image
        filter.shadowAmount = brilliance
        return filter.outputImage
    }

    // Apply highlights adjustment
    func adjustHighlights(image: CIImage, highlights: Float) -> CIImage? {
        let filter = CIFilter.highlightShadowAdjust()
        filter.inputImage = image
        filter.highlightAmount = highlights
        return filter.outputImage
    }
    
    // Apply shadows adjustment
    func adjustShadows(image: CIImage, shadows: Float) -> CIImage? {
        let filter = CIFilter.highlightShadowAdjust()
        filter.inputImage = image
        filter.shadowAmount = shadows
        return filter.outputImage
    }
    
    // Apply contrast adjustment
    func adjustContrast(image: CIImage, contrast: Float) -> CIImage? {
        let filter = CIFilter.colorControls()
        filter.inputImage = image
        filter.contrast = contrast
        return filter.outputImage
    }
    
    // Apply brightness adjustment
    func adjustBrightness(image: CIImage, brightness: Float) -> CIImage? {
        let filter = CIFilter.colorControls()
        filter.inputImage = image
        filter.brightness = brightness
        return filter.outputImage
    }

    // Apply black point adjustment
    func adjustBlackPoint(image: CIImage, blackPoint: Float) -> CIImage? {
        let filter = CIFilter.colorControls()
        filter.inputImage = image
        filter.brightness = blackPoint * -1 // Simulating black point by inversing brightness
        return filter.outputImage
    }

    // Apply saturation adjustment
    func adjustSaturation(image: CIImage, saturation: Float) -> CIImage? {
        let filter = CIFilter.colorControls()
        filter.inputImage = image
        filter.saturation = saturation
        return filter.outputImage
    }

    // Apply vibrance adjustment
    func adjustVibrance(image: CIImage, vibrance: Float) -> CIImage? {
        let filter = CIFilter.vibrance()
        filter.inputImage = image
        filter.amount = vibrance
        return filter.outputImage
    }

    // Apply warmth adjustment
    func adjustWarmth(image: CIImage, warmth: Float) -> CIImage? {
        let filter = CIFilter.temperatureAndTint()
        filter.inputImage = image
        filter.neutral = CIVector(x: CGFloat(warmth), y: 0) // Convert to CGFloat
        return filter.outputImage
    }

    // Apply tint adjustment
    func adjustTint(image: CIImage, tint: Float) -> CIImage? {
        let filter = CIFilter.temperatureAndTint()
        filter.inputImage = image
        filter.targetNeutral = CIVector(x: CGFloat(tint), y: 0) // Convert to CGFloat
        return filter.outputImage
    }
}
