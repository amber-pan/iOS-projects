//
//  ContentView.swift
//  IAmBeautiful
//
//  Created by amber on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var flowerSize = 160
    var body: some View {
        ZStack{
            Color(.systemMint)
                .edgesIgnoringSafeArea(.all)

            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
                Text("I Am Beautiful")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Image("flower").resizable().aspectRatio(contentMode: .fit).frame(width: CGFloat(flowerSize))
                    .padding()
            
              
                Button(action: {self.flowerSize+=5}, label: {
                    Text("Click Me").font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                })
            }
           
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
