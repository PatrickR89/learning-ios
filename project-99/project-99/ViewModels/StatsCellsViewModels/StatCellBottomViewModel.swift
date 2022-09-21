//
//  StatCellBottomViewModel.swift
//  project-99
//
//  Created by Patrick on 21.09.2022..
//

import Foundation
import RealmSwift

class StatCellBottomViewModel {

    private var realm: Realm
    private var currentType: StatsContent
    private var values: Statistics? {
        didSet {
            valueDidChange()
        }
    }

    private var observer: ((Statistics) -> Void)?

    init(as currentType: StatsContent) {
        self.realm = RealmDataService.shared.initiateRealm()
        self.currentType = currentType
        retrieveData(with: currentType)
    }

    private func valueDidChange() {
        guard let observer = observer,
              let values = values else {
            return
        }
        observer(values)
    }

    private func retrieveData(with currentType: StatsContent) {
        guard let userId = UserContainer.shared.loadUser(),
              let realmData = realm.object(ofType: UserGamesStats.self, forPrimaryKey: userId) else {return}
        values = Statistics(totalValue: 1, positiveValue: 1)
        switch currentType {
        case .games:
            values?.totalValue = realmData.numberOfGames
            values?.positiveValue = realmData.numOfGamesWon
        case .pairs:
            values?.totalValue = realmData.cardsClicked
            values?.positiveValue = realmData.pairsRevealed
        case .time:
            break
        }
    }

    func observeValues(_ closure: @escaping (Statistics) -> Void) {
        self.observer = closure
        valueDidChange()
    }
}
