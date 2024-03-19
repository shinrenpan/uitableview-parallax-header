//
//  HomeVO.swift
//
//  Created by Shinren Pan on 2024/3/19.
//

import UIKit

final class HomeVO {
    private(set) lazy var mainView = makeMainView()
    private(set) lazy var list = makeList()
    let header = HomeHeader()
    
    init() {
        addViews()
    }
}

// MARK: - Private

private extension HomeVO {
    // MARK: Add Something
    
    private func addViews() {
        mainView.addSubview(list)
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: mainView.topAnchor),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        
        header.frame = .init(x: 0, y: 0, width: 1000, height: HomeHeader.height)
        list.tableHeaderView = header
    }
    
    // MARK: - Make Something
    
    private func makeMainView() -> UIView {
        let result = UIView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = .white
        
        return result
    }
    
    func makeList() -> UITableView {
        let result = UITableView(frame: .zero, style: .plain)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = .white
        result.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        result.rowHeight = 60
        
        return result
    }
}
