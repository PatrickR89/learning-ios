//
//  TimesCellBottomSubview.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import UIKit

class TimesCellBottomSubview: UIView {

    private let tableView = UITableView()

    var times: [BestTimes] = [
        BestTimes(title: .easy, time: 0.33),
        BestTimes(title: .mediumHard, time: 99.00),
        BestTimes(title: .veryEasy, time: 4.33),
        BestTimes(title: .emotionalDamage, time: 22.33)]

    init(cellType: StatsContent) {
        super.init(frame: .zero)
        setupUI(as: cellType)
        use(AppTheme.self) {
            $0.backgroundColor = $1.backgroundColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(as cellType: StatsContent) {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        TimesSubviewViewCell.register(in: tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            tableView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
}

extension TimesCellBottomSubview: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let time = times[indexPath.row]
        let cell = TimesSubviewViewCell.dequeue(in: tableView, for: indexPath)
        cell.addLabel(with: "\(time.title.rawValue)", and: "\(time.time)")
        return cell
    }
}
