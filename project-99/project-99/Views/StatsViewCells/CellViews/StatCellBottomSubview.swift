//
//  GamesBottomSubview.swift
//  project-99
//
//  Created by Patrick on 20.09.2022..
//

import UIKit
import Combine

class StatCellBottomSubview: UIView {

    private let totalsView = LabelLayoutView()
    private let winsView = LabelLayoutView()
    private let rateView = LabelLayoutView()
    private let labelStack = UIStackView()
    private var cancellables = [AnyCancellable]()

    let viewModel: StatCellBottomViewModel

    init(with viewModel: StatCellBottomViewModel, as cellType: StatsContent) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupBindings()
        setupUI(as: cellType)
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
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

    func setupBindings() {

        viewModel.$values
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] values in
                guard let self = self,
                      let values = values else {return}
                self.totalsView.addValue("\(values.totalValue)")
                self.winsView.addValue("\(values.positiveValue)")

                if values.totalValue != 0 {
                    let rate: Double = (Double(values.positiveValue) / Double(values.totalValue)) * 100.00
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    formatter.maximumFractionDigits = 2
                    if let formattedRate = formatter.string(from: rate as NSNumber) {
                        self.rateView.addValue("\(formattedRate)%")
                    }
                } else {
                    self.rateView.addValue("0.00%")
                }
            })
            .store(in: &cancellables)

        viewModel.$isViewHidden
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] hiddenState in
                self?.isHidden = hiddenState
            })
            .store(in: &cancellables)
    }

    func setupUI(as cellType: StatsContent) {
        self.addSubview(labelStack)

        let views: [UIView] = [totalsView, winsView, rateView]

        labelStack.arrangeView(asColumnWith: views)

        switch cellType {
        case .games:
            totalsView.addTitle("Games played:")
            winsView.addTitle("Games won:")
            rateView.addTitle("Success rate:")
        case .pairs:
            totalsView.addTitle("Total pairs:")
            winsView.addTitle("Pairs removed:")
            rateView.addTitle("Success rate:")
        case .gameTimes:
            break
        }

        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            labelStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            labelStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
