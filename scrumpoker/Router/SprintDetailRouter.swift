//
//  SprintDetailRouter.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import UIKit

class SprintDetailRouter {
//    let view = SprintViewController(nibName: "SprintViewController", bundle: .main)
    let view = AddSprintViewController(nibName: "SprintDetailViewController", bundle: .main)
    let interactor = SprintInteractor()
    let presenter = SprintPresenter()
    
    init() {
//        view.presenter = presenter
//        
//        presenter.view = view
//        presenter.interactor = interactor
//        
//        interactor.output = presenter
    }
    
    func present(on window: UIWindow) {
        window.rootViewController = view
    }
}
