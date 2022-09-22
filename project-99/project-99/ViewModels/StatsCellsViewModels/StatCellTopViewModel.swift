//
//  StatCellTopViewModel.swift
//  project-99
//
//  Created by Patrick on 22.09.2022..
//

import Foundation

class StatCellTopViewModel {
    private var cellType: StatsContent {
        didSet {
            cellTypeDidChange()
        }
    }
    private var extendedCell: Bool {
        didSet {
            cellExtensionDidChange()
        }
    }

    private var typeObserver: ((StatsContent) -> Void)?
    private var extensionObserver: ((Bool) -> Void)?

    init(with cellType: StatsContent, for extendedCell: Bool) {
        self.cellType = cellType
        self.extendedCell = extendedCell
    }

    private func cellTypeDidChange() {
        guard let typeObserver = typeObserver else {
            return
        }
        typeObserver(cellType)
    }

    private func cellExtensionDidChange() {
        guard let extensionObserver = extensionObserver else {
            return
        }
        extensionObserver(extendedCell)
    }

    func observeCellType(_ closure: @escaping (StatsContent) -> Void) {
        self.typeObserver = closure
        cellTypeDidChange()
    }

    func observeCellExtension(_ closure: @escaping (Bool) -> Void) {
        self.extensionObserver = closure
        cellExtensionDidChange()
    }

    func toggleExtension(with value: Bool) {
        self.extendedCell = value
    }
}
