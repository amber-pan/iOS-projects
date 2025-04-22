//
//  ContentView.swift
//  Bounce
//
//  Created by amber on 3/4/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    let bounceScene = BounceScene()
    var body: some View {
        VStack {
            SpriteView(scene: bounceScene.scene)
                .frame(width: 300, height: 300)
            Button("bounce") {
                bounceScene.bounceBox()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

