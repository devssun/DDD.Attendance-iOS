//
//  Optional+Extension.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        return self
    }
    
    @discardableResult
    func then(_ closure: (Wrapped) -> Void) -> Optional {
        if case .some(let item) = self {
            closure(item)
        }
        
        return self
    }
    
    func otherwise(_ closure: () -> Void) {
        if case .none = self {
            closure()
        }
    }
}
