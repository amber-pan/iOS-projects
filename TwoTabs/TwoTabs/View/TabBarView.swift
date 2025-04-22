//
//  TabBarView.swift
//  TwoTabs
//
//  Created by amber on 8/5/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = TabViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            FirstView()
                .tabItem {
                    Label(TabItem.first.title, systemImage: TabItem.first.icon)
                }
                .tag(TabItem.first)

            SecondView()
                .tabItem {
                    Label(TabItem.second.title, systemImage: TabItem.second.icon)
                }
                .tag(TabItem.second)
        }
        .environmentObject(viewModel)
    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}


#Preview {
    TabBarView()
}
