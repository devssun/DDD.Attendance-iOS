//
//  SignUpViewModel.swift
//  DDD.Attendance
//
//  Created by Hakyung Kim on 05/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//
import ReactiveSwift
import ReactiveCocoa

enum SignUpStep: Int {
    case StepOne = 1
    case StepTwo
    case StepThree
    case StepFour
}

class SignUpViewModel {
    let firstName = MutableProperty<String?>(nil)
    let lastName = MutableProperty<String?>(nil)
    let email = MutableProperty<String?>(nil)
    let password = MutableProperty<String?>(nil)
    let position = MutableProperty<String?>(nil)
    
    let step = MutableProperty<SignUpStep>(SignUpStep.StepOne)
    
    lazy private(set) var progressBarSignal: Signal<Float, Never> = { [unowned self] in
        return self.step.signal.map { Float($0.rawValue) * 0.25 }
    }()
    
    lazy private(set) var currentStepSignal: Signal<String, Never> = { [unowned self] in
        return self.step.signal.map { "Step \($0.rawValue)" }
    }()
    
    lazy private(set) var buttonEnabledSignal: SignalProducer<Bool, Never> = { [unowned self] in
        let notEmptySignals = [
            self.firstName.producer.skipNil().map { $0 != "" },
            self.lastName.producer.skipNil().map { $0 != "" }
        ]
        return SignalProducer
            .combineLatest(notEmptySignals)
            .map { $0.reduce(true) {$0 && $1} }
    }()
   
    // Actions
    lazy var nextStepAction: Action<Void, Void, Never> = {
        return Action(execute: { [unowned self] _ in
            return SignalProducer<Void, Never> {
                self.step.value = SignUpStep(rawValue: self.step.value.rawValue + 1) ?? .StepOne
            }
        })
    }()
}
