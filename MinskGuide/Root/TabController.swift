//
//  TabController.swift
//  MinskGuide
//
//  Created by Denis Nazarovs on 20/05/2024.
//

import Foundation

class TabController: ObservableObject {
    @Published var activeTab = Tab.home
    func open(_ tab: Tab) {
        activeTab = tab
    }
}

enum Tab {
    case home
    case aboutus
    case settings
    case search
}
