//
//  ViewOutlet.swift
//  Home
//
//  Created by Joe Pan on 2025/3/5.
//

import UIKit

@MainActor final class ViewOutlet {
    private(set) lazy var mainView = makeMainView()
    private(set) lazy var list = makeList()
    private let header = Header()
    
    init() {
        addViews()
    }
}

// MARK: - Internal

internal extension ViewOutlet {
    func reloadHeader(offsetY: CGFloat) {
        header.reloadUI(offsetY: offsetY)
    }
}

// MARK: - Private

private extension ViewOutlet {
    private func addViews() {
        mainView.addSubview(list)
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: mainView.topAnchor),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        
        header.frame = .init(x: 0, y: 0, width: 1000, height: Header.height)
        list.tableHeaderView = header
    }
    
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
