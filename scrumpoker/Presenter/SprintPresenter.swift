//
//  SprintPresenter.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

protocol SprintPresenterToView: AnyObject {
    func viewDidLoad()
    func deleteSprint(by id: Int)
}

class SprintPresenter {
    weak var view: SprintViewToPresenter?
    var interactor: SprintInteractorInput?
    
    let disposeBag = DisposeBag()
    
    var sprint = BehaviorRelay<Sprint?>(value: nil)
    
    func bind() {
        print("bind Presenter")
        self.interactor?.fetchAllSprints()
    }
}

extension SprintPresenter: SprintPresenterToView {
    func deleteSprint(by id: Int) {
        self.interactor?.deleteSprint(by: id)
    }
    
    func viewDidLoad() {
        bind()
    }
}

extension SprintPresenter: SprintInteractorOutput {

    func fetchedSprintList(sprints: [Sprint]) {
        self.view?.showSprints(sprints: sprints)
    }
    
    func fetchedSprint(sprint: Sprint) {
        
    }
    
    func sprintWasDeleted() {
        
    }
    
    func errorOccurred(error: Error?) {
        view?.setLoading(false)
    }
}
