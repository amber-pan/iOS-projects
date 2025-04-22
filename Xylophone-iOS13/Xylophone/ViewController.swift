//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.

//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

     func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        
        playSound(soundName:  sender.currentTitle!)
        
        //Reduces the pressed button  opacity to half.
        sender.alpha = 0.5

        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        
    }
    
   
    
   
}

}
