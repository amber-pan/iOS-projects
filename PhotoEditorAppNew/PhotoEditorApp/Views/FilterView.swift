//
//  FilterView.swift
//  PhotoEditorApp
//
//  Created by amber on 10/13/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedFilter: PhotoFilter

    var body: some View {
        HStack {
            Button("Vivid") {
                selectedFilter = .vivid
            }
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
        
            Button("Vivid Warm") {
                selectedFilter = .vividWarm
            }     .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
