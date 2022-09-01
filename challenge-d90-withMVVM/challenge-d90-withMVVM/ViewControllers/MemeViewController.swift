//
//  MemeViewController.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeViewController: UIViewController {

    private let memeView = MemeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "CLOSE",
            style: .plain,
            target: self,
            action: #selector(closeSelf))
    }
}

private extension MemeViewController {
    @objc func closeSelf() {
        self.dismiss(animated: true)
    }

    func setupUI() {
        view.addSubview(memeView)
        memeView.frame = view.bounds
        memeView.delegate = self
    }
}

extension MemeViewController: MemeViewDelegate {
    func memeViewDidTapImage(_ view: MemeView) {
        print("tapped!")
    }
}
