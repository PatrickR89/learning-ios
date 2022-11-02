//
//  StatCellTopSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit
import Combine

class StatCellTopSubview: UIView {

    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    let viewModel: StatCellTopViewModel
    private var cancellables = [AnyCancellable]()

    init(as cellType: StatsContent, isExtended bottomView: Bool) {
        self.viewModel = StatCellTopViewModel(with: cellType, for: bottomView)
        super.init(frame: .zero)
        setupUI()
        setupBindings()

        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
            $0.titleLabel.textColor = $1.textColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        cancellables.forEach {
            $0.cancel()
        }
    }

    func setupUI() {
        self.setupLabelViews(titleLabel, and: nil)
        self.setupImageView(arrowImageView)
        titleLabel.text = "Games"
        arrowImageView.image = UIImage(systemName: "chevron.down")

    }

    func setupBindings() {

        viewModel.$cellType
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                switch value {
                case .games:
                    self?.titleLabel.text = "Games"
                case .pairs:
                    self?.titleLabel.text = "Pairs"
                case .gameTimes:
                    self?.titleLabel.text = "Time"
                }
            })
            .store(in: &cancellables)

        viewModel.$extendedCell
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isExtended in
                if !isExtended {
                    self?.arrowImageView.image = UIImage(systemName: "chevron.up")
                } else {
                    self?.arrowImageView.image = UIImage(systemName: "chevron.down")
                }
            })
            .store(in: &cancellables)
    }
}
