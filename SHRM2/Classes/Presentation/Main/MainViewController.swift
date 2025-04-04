//
//  MainViewController.swift
//  ITExams
//
//  Created by Андрей Чернышев on 29.03.2022.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    lazy var mainView = MainView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var coordinator = MainViewCoordinator(parentVC: self)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addActionsToTabs()
        
        rx.methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.update(selectedTab: .practice)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension MainViewController {
    static func make() -> MainViewController {
        let vc = MainViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
 
// MARK: Private
private extension MainViewController {
    func addActionsToTabs() {
        Observable
            .merge([
                mainView.tabView.planItem
                    .rx.tap.map { TabView.Tab.plan },
                
                mainView.tabView.practiceItem
                    .rx.tap.map { TabView.Tab.practice },
                
                mainView.tabView.profileItem
                    .rx.tap.map { TabView.Tab.profile }
            ])
            .subscribe(onNext: { [weak self] tab in
                self?.update(selectedTab: tab)
            })
            .disposed(by: disposeBag)
    }
    
    func update(selectedTab: TabView.Tab) {
        coordinator.change(tab: selectedTab)
    }
}
