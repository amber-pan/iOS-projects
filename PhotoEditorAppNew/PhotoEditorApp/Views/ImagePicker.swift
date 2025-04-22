//
//  ImagePicker.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import SwiftUI
import PhotosUI


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image,
                    _ in
//                    guard let self = self else { return }
                    if let uiImage = image as? UIImage {
                        
                        print("new image selected with size: \(uiImage.size)")
                        // Dispatch the update to the main thread
                        DispatchQueue.main.async {
                            self?.parent.image = uiImage
                            print("CGImage created successfully with size: \(uiImage.size)")
                            // Call applyAdjustments when the image is set
                            if let image = self?.parent.image {
                                             // You can trigger applyAdjustments here
                                             let photoEditorViewModel = PhotoEditorViewModel()
                                             photoEditorViewModel.image = image
                                             photoEditorViewModel.applyAdjustments()
                                         }
                        }
                    }
                }
                   
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

