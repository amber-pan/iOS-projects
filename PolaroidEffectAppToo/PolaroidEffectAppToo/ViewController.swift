//
//  ViewController.swift
//  PolaroidEffectAppToo
//
//  Created by amber on 10/18/24.
//
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let photoEditorView = PhotoEditorView() // Initialize the PhotoEditorView

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        print("setupUI")
        // Add the PhotoEditorView to the view hierarchy
        view.addSubview(photoEditorView)

        // Set constraints or frame for PhotoEditorView
        photoEditorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoEditorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoEditorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoEditorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoEditorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Add navigation button to select photo
        let selectPhotoButton = UIBarButtonItem(title: "Select Photo", style: .plain, target: self, action: #selector(selectPhoto))
        navigationItem.rightBarButtonItem = selectPhotoButton
        


        // Connect actions
        photoEditorView.applyButton.addTarget(self, action: #selector(applyEffect), for: .touchUpInside)
    }

    @objc func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func applyEffect() {
        guard let image = photoEditorView.imageView.image else { return }
        let grainIntensity = photoEditorView.grainSlider.value
        let scratchIntensity = photoEditorView.scratchSlider.value

        let filteredImage = GrainAndScratchFilter.apply(to: image, grainIntensity: grainIntensity, scratchIntensity: scratchIntensity)
        photoEditorView.imageView.image = filteredImage
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            photoEditorView.imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
