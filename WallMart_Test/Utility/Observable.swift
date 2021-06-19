//
//  Observable.swift
//  WallMart_Test
//
//  Created  on 19/06/21.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    private var valueChanged: ((T) -> Void)?

    init(value: T) {
        self.value = value
    }

    func addObserver(_ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        onChange?(value)
    }

    func removeObserver() {
        valueChanged = nil
    }

}
