//
//  TabItem.swift
//  TwoTabs
//
//  Created by amber on 8/5/24.
//

import Foundation
import SwiftUI

enum TabItem: String, CaseIterable {
    case first = "First"
    case second = "Second"

    var title: String {
        switch self {
        case .first:
            return "First Tab"
        case .second:
            return "Second Tab"
        }
    }

    var icon: String {
        switch self {
        case .first:
            return "1.circle"
        case .second:
            return "2.circle"
        }
    }
}
