//
//  StatCellBottomViewModel.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import Foundation
import Combine

class StatCellBottomViewModel {

    private var currentType: StatsContent
    @Published private(set) var values: Statistics?

    @Published private(set) var isViewHidden: Bool = true {
        didSet {
            delegate?.statCellBottomViewModel(self, didChangeViewHiddenState: isViewHidden)
        }
    }

    weak var delegate: StatCellBottomViewModelDelegate?

    init(as currentType: StatsContent) {
        self.currentType = currentType
        retrieveData(with: currentType)
    }

    private func retrieveData(with currentType: StatsContent) {

        let realmData = RealmDataService.shared.loadStatistics()

        values = Statistics(totalValue: 1, positiveValue: 1)
        switch currentType {
        case .games:
            values?.totalValue = realmData.numberOfGames
            values?.positiveValue = realmData.numOfGamesWon
        case .pairs:
            values?.totalValue = realmData.cardsClicked
            values?.positiveValue = realmData.pairsRevealed
        case .gameTimes:
            break
        }
    }

    func changeHiddenState(_ state: Bool) {
        self.isViewHidden = state
    }
}
