//
//  HomeVM.swift
//
//  Created by Shinren Pan on 2024/3/19.
//

import Combine
import UIKit

final class HomeVM {
    @Published private(set) var state = HomeModels.State.none
    private(set) var model = HomeModels.DisplayModel()
}
