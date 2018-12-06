//
//  AboutViewController.swift
//  EOS
//
//  Created DKM on 2018/7/19.
//  Copyright © 2018年 com.nbltrust. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift

class AboutViewController: BaseViewController {
    @IBOutlet weak var introView: CustomCellView!

    @IBOutlet weak var updateView: CustomCellView!
    
	var coordinator: (AboutCoordinatorProtocol & AboutStateManagerProtocol)?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupEnent()
    }

    func setupUI() {
        self.title = R.string.localizable.mine_about.key.localized()
        introView.title = R.string.localizable.about_info.key.localized()
        introView.subTitle = ""
        updateView.title = R.string.localizable.about_update.key.localized()
        updateView.subTitle = ""
    }

    func setupEnent() {
        introView.rx.tapGesture().when(.recognized).subscribe(onNext: {[weak self] _ in
            guard let `self` = self else { return }
            self.coordinator?.openReleaseNotes()
        }).disposed(by: disposeBag)
    }

    override func configureObserveState() {

    }
}
