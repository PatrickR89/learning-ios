//
//  TimesCellBottomSubview.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import UIKit
import Combine

class TimesCellBottomSubview: UIView {

    private let tableView = UITableView()
    private let viewModel: TimesCellBottomViewModel
    private var timesUpdate: AnyCancellable?

    init(with viewModel: TimesCellBottomViewModel, cellType: StatsContent) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI(as: cellType)
        setupBindings()
        viewModel.loadTimes()
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        timesUpdate?.cancel()
    }

    func setupUI(as cellType: StatsContent) {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        TimesSubviewViewCell.register(in: tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            tableView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }

    private func setupBindings() {

        timesUpdate = viewModel.$times
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })

    }
}

extension TimesCellBottomSubview: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.provideTimesLength()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let time = viewModel.provideSingleTimeByIndex(for: indexPath.row)
        let cell = TimesSubviewViewCell.dequeue(in: tableView, for: indexPath)
        let tempTime = String(format: "%.2f", time.time)
        cell.addLabelsText(for: viewModel.converTimeTitle(for: time.title), and: "\(tempTime)")
        return cell
    }
}

extension TimesCellBottomSubview: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
