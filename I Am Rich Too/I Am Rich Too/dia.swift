//
//  ContentView.swift
//  I Am Rich Too
//
//  Created by Amber  Pan on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var diamondSize = 40
    var body: some View {
        ZStack{
            Color(.systemMint)
                .edgesIgnoringSafeArea(.all)

            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
                Text("I Am Rich")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Image("diamond").resizable().aspectRatio(contentMode: .fit).frame(width: CGFloat(diamondSize))
                    .padding()
            
              
                Button(action: {self.diamondSize+=5}, label: {
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
