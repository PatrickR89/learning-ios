//
//  CardsColumn.swift
//  project-99
//
//  Created by Patrick on 24.10.2022..
//

import UIKit
import Combine

class CardsColumn: UIStackView {

    var cards = [GameCardView]()
    var viewModel: CardsColumnViewModel
    private var cancellable: AnyCancellable?

    init(cards: [GameCard], in level: Level) {
        self.viewModel = CardsColumnViewModel(in: level)
        super.init(frame: .zero)
        viewModel.setupCards(with: cards)
        setupBindings()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBindings() {
        cancellable = viewModel.$cards
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] cards in
                var tempCards = [GameCardView]()

                for (index, card) in cards.enumerated() {
                    tempCards.insert(GameCardView(), at: index)
                    tempCards[index].configCellBasicLayout()
                    tempCards[index].setupUI(with: card)
                }

                self?.setupCards(withCards: tempCards)
            })
    }

    func setupCards(withCards cards: [GameCardView]) {
        self.cards = cards
        self.axis = .vertical

        self.autoresizesSubviews = true

        let dependantWidth = UIScreen.main.bounds.width / CGFloat(GridLayout(viewModel.level).columns)
        var scale: CGFloat = 0.0
        if UIScreen.main.scale >= 3 {
            scale = 0.82
        } else if UIScreen.main.scale >= 2 {
            scale = 0.72
        }
        cards.forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        for (index, card) in cards.enumerated() {

            self.distribution = .equalCentering
            self.alignment = .center

            card.heightAnchor.constraint(equalToConstant: dependantWidth * scale).isActive = true
            if index > 0 {
                card.heightAnchor.constraint(equalTo: cards[index - 1].heightAnchor).isActive = true
            }
            card.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
            card.widthAnchor.constraint(equalTo: card.heightAnchor).isActive = true

        }
    }
}
