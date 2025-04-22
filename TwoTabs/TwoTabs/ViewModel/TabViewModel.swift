//
//  TabViewModel.swift
//  TwoTabs
//
//  Created by amber on 8/5/24.
//

import Foundation
import SwiftUI

class TabViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .first
}
