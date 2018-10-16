//
//  FingerCoordinator.swift
//  EOS
//
//  Created zhusongyu on 2018/10/12.
//  Copyright © 2018 com.nbltrustdev. All rights reserved.
//

import UIKit
import ReSwift
import NBLCommonModule
import Async

protocol FingerCoordinatorProtocol {
    func pushToManagerFingerVC(model: WalletManagerModel, index: Int)
}

protocol FingerStateManagerProtocol {
    var state: FingerState { get }
    
    func switchPageState(_ state:PageState)
}

class FingerCoordinator: NavCoordinator {
    var store = Store(
        reducer: FingerReducer,
        state: nil,
        middleware:[TrackingMiddleware]
    )
    
    var state: FingerState {
        return store.state
    }
    
    override class func start(_ root: BaseNavigationController, context:RouteContext? = nil) -> BaseViewController {
        let vc = R.storyboard.wallet.fingerViewController()!
        let coordinator = FingerCoordinator(rootVC: root)
        vc.coordinator = coordinator
        coordinator.store.dispatch(RouteContextAction(context: context))
        return vc
    }

    override func register() {
        Broadcaster.register(FingerCoordinatorProtocol.self, observer: self)
        Broadcaster.register(FingerStateManagerProtocol.self, observer: self)
    }
}

extension FingerCoordinator: FingerCoordinatorProtocol {
    func pushToManagerFingerVC(model: WalletManagerModel, index: Int) {
        if let vc = R.storyboard.wallet.deleteFingerViewController() {
            let coordinator = DeleteFingerCoordinator(rootVC: self.rootVC)
            vc.coordinator = coordinator
            vc.model = model
            vc.index = index
            self.rootVC.pushViewController(vc, animated: true)
        }
    }
}

extension FingerCoordinator: FingerStateManagerProtocol {
    func switchPageState(_ state:PageState) {
        Async.main {
            self.store.dispatch(PageStateAction(state: state))
        }
    }
}
