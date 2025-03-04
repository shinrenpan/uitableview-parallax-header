//
//  ViewController.swift
//  Home
//
//  Created by Joe Pan on 2025/3/5.
//

import Combine
import UIKit

public final class ViewController: UIViewController {
    private let vo = ViewOutlet()
    private let vm = ViewModel()
    private let router = Router()
    private var binding: Set<AnyCancellable> = .init()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
}

// MARK: - Private

private extension ViewController {
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
    
    func stateNone() {}
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.items[indexPath.row]
        
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

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != vo.list { return }
        
        let offsetY = scrollView.contentOffset.y
        vo.reloadHeader(offsetY: offsetY)
    }
}
