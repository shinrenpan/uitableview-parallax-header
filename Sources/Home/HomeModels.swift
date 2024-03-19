//
//  HomeModels.swift
//
//  Created by Shinren Pan on 2024/3/19.
//

import UIKit

enum HomeModels {}

// MARK: - Action

extension HomeModels {
    enum Action {}
}

// MARK: - State

extension HomeModels {
    enum State {
        case none
    }
}

// MARK: - Other Model for DisplayModel

extension HomeModels {
    struct Item {
        let name: String
        let isSelected: Bool
    }
}

// MARK: - Display Model for ViewModel

extension HomeModels {
    final class DisplayModel {
        let items: [Item] = [
            .init(name: "Apple Watch", isSelected: true)
        ]
    }
}
