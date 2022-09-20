//
//  StatsViewController.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatsViewController: UIViewController {

    private let viewModel: StatsViewModel
    private let statsView: StatsView

    init(with viewModel: StatsViewModel) {
        self.viewModel = viewModel
        self.statsView = StatsView(with: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    private func setupUI() {
        view.addSubview(statsView)
        statsView.frame = view.frame
    }
}
