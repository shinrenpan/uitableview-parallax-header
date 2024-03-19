//
//  HomeVC.swift
//
//  Created by Shinren Pan on 2024/3/19.
//

import Combine
import UIKit

final class HomeVC: UIViewController {
    private let vo = HomeVO()
    private let vm = HomeVM()
    private let router = HomeRouter()
    private var binding: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
}

// MARK: - Private

private extension HomeVC {
    // MARK: Setup Something

    func setupSelf() {
        navigationItem.title = "Home"
        view.backgroundColor = vo.mainView.backgroundColor
        router.vc = self
    }

    func setupBinding() {
        vm.$state.receive(on: DispatchQueue.main).sink { [weak self] state in
            if self?.viewIfLoaded?.window == nil { return }

            switch state {
            case .none:
                self?.stateNone()
            }
        }.store(in: &binding)
    }

    func setupVO() {
        view.addSubview(vo.mainView)
        
        NSLayoutConstraint.activate([
            vo.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vo.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vo.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vo.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        vo.list.dataSource = self
        vo.list.delegate = self
    }
    
    // MARK: - Handle State

    func stateNone() {}
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.model.items[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.textLabel?.text = item.name
            cell.accessoryType = item.isSelected ? .checkmark : .none
            return cell
        }
        
        let result = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        result.textLabel?.text = item.name
        result.accessoryType = item.isSelected ? .checkmark : .none
        return result
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != vo.list { return }
        
        let offsetY = scrollView.contentOffset.y
        vo.header.reloadUI(offsetY: offsetY)
    }
}
