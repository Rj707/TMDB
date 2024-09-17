//
//  Observable.swift
//  Practice
//
//  Created by iApple Basement on 27/05/2024.
//

import Foundation


class Observable<T> {
    typealias Observer = (T) -> Void
    
    var value: T {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [Observer] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ observer: @escaping Observer) {
        observers.append(observer)
        observer(value)
    }
    
    private func notifyObservers() {
        observers.forEach { $0(value) }
    }
}
