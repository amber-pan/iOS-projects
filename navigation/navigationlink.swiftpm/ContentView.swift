import SwiftUI

struct ContentView: View {
   
     @State private var selectedColour = 0

     let colours = ["red", "blue", "yellow"]

    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Select a Color")
                Picker(selection: $selectedColour, label: Text("Select Color")) {
                    ForEach(0..<colours.count, id: \.self) {
                        Text(colours[$0])
                    }}
                let color = colours[selectedColour]
                let textColor = Color(color)
                NavigationLink("Display new view", value: colours[selectedColour])
                    .font(.headline)
                    .navigationDestination(for: String.self) {
                    
                text in
                               VStack{
                                   Text("the color you chose is:")
                Text(text)
                    .font(.largeTitle)
//                    .foregroundColor(textColor)
            }
        }
//
//                                Image(systemName: "globe")
//                                    .imageScale(.large)
//                                    .foregroundColor(.accentColor)
//                //            }
//                                Text("Hello, world!")
            }
            .navigationTitle("navigation bar")
        }
        
    }
}
