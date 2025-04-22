//
//  PhotoEditorView.swift
//  PolaroidEffectAppNew
//
//  Created by amber on 10/18/24.


import UIKit

class PhotoEditorView: UIView {

    // UI Elements
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    let grainLabel: UILabel = {
        let label = UILabel()
        label.text = "Grain Intensity"
        return label
    }()

    let grainSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        return slider
    }()
    
    // Label to display grain intensity value
    let grainValueLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        return label
    }()

    let scratchLabel: UILabel = {
        let label = UILabel()
        label.text = "Scratch Intensity"
        return label
    }()

    let scratchSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        return slider
    }()
    
    // Label to display scratch intensity value
    let scratchValueLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        return label
    }()

    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply Effect", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white

        // Add subviews
        addSubview(imageView)
        addSubview(grainLabel)
        addSubview(grainSlider)
        addSubview(grainValueLabel) // Add the grain value label
        addSubview(scratchLabel)
        addSubview(scratchSlider)
        addSubview(scratchValueLabel) // Add the scratch value label
        addSubview(applyButton)

        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        grainLabel.translatesAutoresizingMaskIntoConstraints = false
        grainSlider.translatesAutoresizingMaskIntoConstraints = false
        grainValueLabel.translatesAutoresizingMaskIntoConstraints = false
        scratchLabel.translatesAutoresizingMaskIntoConstraints = false
        scratchSlider.translatesAutoresizingMaskIntoConstraints = false
        scratchValueLabel.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // ImageView constraints
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            // Grain slider and label
            grainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            grainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            grainSlider.topAnchor.constraint(equalTo: grainLabel.bottomAnchor, constant: 5),
            grainSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            grainSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Grain value label
            grainValueLabel.topAnchor.constraint(equalTo: grainSlider.bottomAnchor, constant: 5),
            grainValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Scratch slider and label
            scratchLabel.topAnchor.constraint(equalTo: grainValueLabel.bottomAnchor, constant: 20),
            scratchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scratchSlider.topAnchor.constraint(equalTo: scratchLabel.bottomAnchor, constant: 5),
            scratchSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scratchSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Scratch value label
            scratchValueLabel.topAnchor.constraint(equalTo: scratchSlider.bottomAnchor, constant: 5),
            scratchValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Apply button
            applyButton.topAnchor.constraint(equalTo: scratchValueLabel.bottomAnchor, constant: 20),
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Add target to sliders to update values
        grainSlider.addTarget(self, action: #selector(grainSliderValueChanged(_:)), for: .valueChanged)
        scratchSlider.addTarget(self, action: #selector(scratchSliderValueChanged(_:)), for: .valueChanged)
    }

    @objc private func grainSliderValueChanged(_ sender: UISlider) {
        grainValueLabel.text = String(format: "%.0f", sender.value) // Update grain value label
    }

    @objc private func scratchSliderValueChanged(_ sender: UISlider) {
        scratchValueLabel.text = String(format: "%.0f", sender.value) // Update scratch value label
    }
}
