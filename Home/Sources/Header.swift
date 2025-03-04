//
//  Header.swift
//  Home
//
//  Created by Joe Pan on 2025/3/5.
//

import UIKit

final class Header: UIView {
    static let height = 280.0
    private let imgView = UIImageView(image: .init(named: "banner"))
    
    init() {
        super.init(frame: .zero)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal

internal extension Header {
    func reloadUI(offsetY: CGFloat) {
        if offsetY < 0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offsetY, 0)
            let scaleFactor = 1 + (-1 * offsetY / (Header.height / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            imgView.layer.transform = transform
        }
        else {
            imgView.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - Private

private extension Header {
    private func setupSelf() {
        backgroundColor = .white
        clipsToBounds = true
    }
    
    func addViews() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        
        addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
