//
//  PhotoFilters.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import CoreImage

enum PhotoFilter: String {
    case vivid = "CIColorControls"
    case vividWarm = "CITemperatureAndTint"

    func createFilter() -> CIFilter? {
        switch self {
        case .vivid:
            // Vivid filter using saturation adjustment
            return CIFilter(name: self.rawValue, parameters: [kCIInputSaturationKey: 1.5])
            
        case .vividWarm:
            // Vivid Warm filter using temperature and tint adjustments
            let filter = CIFilter(name: self.rawValue)
            filter?.setValue(CIVector(x: 6500, y: 0), forKey: "inputNeutral")  // x for temperature, y for tint
            return filter
        }
    }
}
