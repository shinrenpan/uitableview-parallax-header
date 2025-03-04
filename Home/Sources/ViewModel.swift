//
//  ViewModel.swift
//  Home
//
//  Created by Joe Pan on 2025/3/5.
//

import Combine
import UIKit

final class ViewModel {
    @Published private(set) var state = State.none
    private(set) var items: [Item]
    
    init() {
        self.items = [
            .init(name: "Apple Watch", isSelected: true)
        ]
    }
}
