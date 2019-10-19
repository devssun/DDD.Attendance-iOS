//
//  SignUpViewModel.swift
//  DDD.Attendance
//
//  Created by Hakyung Kim on 05/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//
import ReactiveSwift
import ReactiveCocoa
import UIKit

enum SignUpStep: Int {
    case StepOne = 1
    case StepTwo
    case StepThree
    case StepFour
}

enum Position: Int {
    case None = -1
    case Designer
    case And
    case iOS
    case Backend
}

class SignUpViewModel {
    let firstName = MutableProperty<String?>(nil)
    let lastName = MutableProperty<String?>(nil)
    let email = MutableProperty<String?>(nil)
    let password = MutableProperty<String?>(nil)
    let position = MutableProperty<Position>(.None)
    
    let step = MutableProperty<SignUpStep>(.StepThree)
    
    lazy private(set) var progressBarSignal: Signal<Float, Never> = { [unowned self] in
        return self.step.signal.map { Float($0.rawValue) * 0.25 }
    }()
    
    lazy private(set) var currentStepSignal: Signal<String, Never> = { [unowned self] in
        return self.step.signal.map { "Step \($0.rawValue)" }
    }()
    
    lazy private(set) var stepOneBtnEnabledSignal: SignalProducer<Bool, Never> = { [unowned self] in
        let notEmptySignals = [
            self.firstName.producer.skipNil().map { $0 != "" },
            self.lastName.producer.skipNil().map { $0 != "" },
        ]
        return SignalProducer
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) { $0 && $1 } }
    }()
    
    lazy private(set) var stepTwoBtnEnabledSignal: SignalProducer<Bool, Never> = { [unowned self] in
        let notEmptySignals = [
            self.email.producer.skipNil().map { $0 != "" },
            self.password.producer.skipNil().map { $0 != "" },
        ]
        return SignalProducer
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) { $0 && $1 } }
    }()
    
    lazy private(set) var stepThreeBtnEnabledSignal: SignalProducer<Bool, Never> = { [unowned self] in
       return self.position.producer.map { $0 != .None }
    }()
   
    // Actions
    lazy var nextStepAction: Action<Void, Void, Never> = {
        return Action(execute: { [unowned self] _ in
            return SignalProducer<Void, Never> {
                self.step.value = SignUpStep(rawValue: self.step.value.rawValue + 1) ?? .StepOne
            }
        })
    }()
    
    func signUpTapped(position: Position) {
        self.position.value = position
    }
    
    init() {
        
    }
}
