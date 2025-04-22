//
//  PhotoEditorView.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import SwiftUI
import PhotosUI

struct PhotoEditorView: View {
    @StateObject var viewModel = PhotoEditorViewModel()  // Use @StateObject to initialize the view model
    @State private var selectedFilter: PhotoFilter = .vivid  // For managing the selected filter

    var body: some View {
       
            VStack {
                // "Select Image" Button
                Button(action: {
                    viewModel.isPickerPresented = true
                }) {
                    Text("Select Image")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Display the processed image
                if let processedImage = viewModel.processedImage {
                    Image(uiImage: processedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .padding()
                
                } else if let selectedImage = viewModel.image {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .padding()
                } else {
                    Text("No Image Selected")
                        .foregroundColor(.gray)
                        .frame(height: 300)
                }

              
                // Sliders for adjustments with consistent range (-100 to 100)
                ScrollView {
                    VStack {
                    AdjustmentSliderView(value: $viewModel.exposure, label: "Exposure", range: -100...100)
//                            .onChange(of: viewModel.exposure, perform: { _ in
//                        viewModel.applyAdjustments()
//                    }
//                    )
                    AdjustmentSliderView(value: $viewModel.brilliance, label: "Brilliance", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.highlights, label: "Highlights", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.shadows, label: "Shadows", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.contrast, label: "Contrast", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.brightness, label: "Brightness", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.blackPoint, label: "Black Point", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.saturation, label: "Saturation", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.vibrance, label: "Vibrance", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.warmth, label: "Warmth", range: -100...100)
                    AdjustmentSliderView(value: $viewModel.tint, label: "Tint", range: -100...100)
                }
                .padding()
//
                Spacer()
                    // Filter selection
                    FilterView(selectedFilter: $selectedFilter)

            }
          
            
        }
        .onChange(of: selectedFilter) { filter in
            viewModel.applyFilter(filter)  // Apply selected filter when changed
        }
        .sheet(isPresented: $viewModel.isPickerPresented) {
            ImagePicker(image: $viewModel.image)
        }
    }
}
