//
//  LoginViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import SnapKit
import CHIPageControl
import ReactiveSwift

class LoginViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var loginPopupButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private let transition = LoginTransitionCoordinator()
    private let dataSource = LoginDataSource()
    private let posterModels = [PosterModel(poster: #imageLiteral(resourceName: "onboarding1Character"),
                                            title: "간편한 출석체크",
                                            description: "QR코드를 통한 본인 인증으로\n5초면 출석체크 완료!"),
                                PosterModel(poster: #imageLiteral(resourceName: "onboarding2Character"),
                                            title: "스터디 일정 체크",
                                            description: "세션 날짜와 장소, 시간대까지\n이제 앱에서 바로 체크하세요 :)!")]
    private var pageControl: CHIPageControlAji?
    
    static func instantiateViewController() -> LoginViewController {
        return Storyboard.login.viewController(LoginViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        collectionView.then {
            $0.dataSource = dataSource
        }
    }
    
    override func bindStyle() {
        super.bindStyle()
        
        loginPopupButton.then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 25
        }
        
        pageControl.then {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
            collectionView.addSubview($0)
            $0.numberOfPages = posterModels.count
            $0.tintColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
            $0.currentPageTintColor = UIColor(red: 54/255, green: 159/255, blue: 255/255, alpha: 1.0)
            $0.snp.makeConstraints { make in
                make.centerY.equalTo(collectionView.snp.centerY)
                make.top.equalTo(view.snp.top).offset(70)
            }
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.prepareLoginPopupViewController <~ reactive.viewWillAppear
        
        reactive.presentLoginPopupViewController <~ loginPopupButton.reactive
            .controlEvents(.touchUpInside)
        
        reactive.presentSignUpViewController <~ signUpButton.reactive
            .controlEvents(.touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.load(from: posterModels)
        collectionView.reloadData()
    }
}

// MARK: - Private
private extension LoginViewController {
    
    func presentLoginPopupViewController() {
        if let viewControllerToPresent = transition.toViewController {
            present(viewControllerToPresent, animated: true)
        }
    }
    
    func prepareLoginPopupViewController() {
        transition.prepareViewforCustomTransition(fromViewController: self)
    }
    
    func presentSignUpViewController() {
        let signUpViewController = SignUpViewController.instantiateViewController()
        present(signUpViewController, animated: true)
    }
}

// MARK: - Reactive
extension Reactive where Base: LoginViewController {
    
    var presentLoginPopupViewController: BindingTarget<UIButton> {
        return makeBindingTarget({ base, _ in
            base.presentLoginPopupViewController()
        })
    }
    
    var prepareLoginPopupViewController: BindingTarget<Void> {
        return makeBindingTarget({ base, _ in
            base.prepareLoginPopupViewController()
        })
    }
    
    var presentSignUpViewController: BindingTarget<UIButton> {
        return makeBindingTarget({ base, _ in
            base.presentSignUpViewController()
        })
    }
}

extension LoginViewController: InteractiveTransitionableViewController {
    
    var interactivePresentTransition: InteractiveAnimator? {
        return transition.interactivePresentTransition
    }
    
    var interactiveDismissTransition: InteractiveAnimator? {
        return transition.interactiveDismissTransition
    }
}
