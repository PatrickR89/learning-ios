//
//  StatsView.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit

class StatsView: UIView {
    private let viewModel: StatsViewModel

    init(with viewModel: StatsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.reloadInputViews()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
    }
}
