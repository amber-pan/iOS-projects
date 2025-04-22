//
//  AdjustmentSliderView.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import SwiftUI

struct AdjustmentSliderView: View {
    @Binding var value: Float
    let label: String
    let range: ClosedRange<Float>
    
    var body: some View {
        VStack {
            HStack {
                Text("\(label): \(Int(value))")  // Show the current value as an integer
                    .font(.headline)
                Spacer()
                //               }
                Slider(value: $value, in: range)
                    .padding()
            }
        }
    }
}
