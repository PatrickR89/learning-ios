//
//  ObservableObject.swift
//  challenge-d74-withMVVM
//
//  Created by Patrick on 23.08.2022..
//

import UIKit

class ObservableObject<T> {
    var value: T? {
        didSet {
            valueDidChange()
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    private var listeners: [(T?) -> Void] = []

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
        valueDidChange()
    }

    private func valueDidChange() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let value = self.value else {return}
            self.listeners.forEach {
                $0(value)
            }
        }
    }
}
