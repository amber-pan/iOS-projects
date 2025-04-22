//
//  ViewController.swift
//  ThingRater
//
//  Created by Will McGinty on 6/27/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var firstStarButton: UIButton!
    @IBOutlet var secondStarButton: UIButton!
    @IBOutlet var thirdStarButton: UIButton!
    @IBOutlet var fourthStarButton: UIButton!
    @IBOutlet var fifthStarButton: UIButton!

    @IBOutlet var imageView: UIImageView!
    
    var ratedThing: RatedThing?


    override func viewDidLoad() {
        super.viewDidLoad()
        if ratedThing == nil {
            ratedThing = RatedThing(name: "", rating: 0, image: nil)
        }
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = ratedThing?.name
        let allButtons = [firstStarButton,secondStarButton,thirdStarButton,fourthStarButton,fifthStarButton]
        var countDown = ratedThing?.rating ?? 0
        while countDown > 0 {
            countDown -= 1
            allButtons[countDown]?.isSelected = true
        }
        imageView.image = ratedThing?.image
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        print("changed")
    }

    @IBAction func starButtonTapped(_ sender: UIButton) {

        let allButtons = [firstStarButton,secondStarButton,thirdStarButton,fourthStarButton,fifthStarButton]

        ratedThing?.rating = 0

        for button in allButtons {
            button?.isSelected = false
        }

        for button in allButtons {
            button?.isSelected = true
            ratedThing?.rating += 1
            if button == sender {
                break
            }
        }

    }

    @IBAction func imageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
     /*   picker.sourceType = .camera  */ //use device camera to take photos, but will //disalbe picking from album
        present(picker, animated: true)
    }

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var baseText = textField.text ?? ""
        baseText += string
        ratedThing?.name = baseText
        titleLabel.text = baseText
        return true
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage]
        imageView.image = selectedImage as? UIImage
        ratedThing?.image = imageView.image
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {

}
