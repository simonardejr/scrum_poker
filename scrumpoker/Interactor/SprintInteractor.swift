//
//  SprintInteractor.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import Foundation
import RxSwift

protocol SprintInteractorOutput: AnyObject {
    func fetchedSprintList(sprints: [Sprint])
    func fetchedSprint(sprint: Sprint)
    func sprintWasDeleted()
    func errorOccurred(error: Error?)
}

protocol SprintInteractorInput: AnyObject {
    func fetchAllSprints()
    func fetchSprint(by id: Int)
    func deleteSprint(by id: Int)
    func addSprint(sprint: Sprint)
}

class SprintInteractor {
    weak var output: SprintInteractorOutput?
    let disposeBag = DisposeBag()
}

extension SprintInteractor: SprintInteractorInput {

    func fetchAllSprints() {
        print("Fetch all Sprints Interactor")
        SprintClient.fetchAllSprints().subscribe { [weak self = self] event in
            if let sprints = event.element {
                self?.output?.fetchedSprintList(sprints: sprints)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func fetchSprint(by id: Int) {
        SprintClient.fetchSprint(by: id).subscribe { [weak self = self] event in
            if let sprint = event.element {
                self?.output?.fetchedSprint(sprint: sprint)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func deleteSprint(by id: Int) {
        SprintClient.deleteSprint(by: id).subscribe { [weak self] event in
            if event.isCompleted {
                self?.output?.sprintWasDeleted()
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func addSprint(sprint: Sprint) {
        SprintClient.addSprint(sprint: sprint).subscribe { [weak self] event in
            if event.isCompleted {
                // 
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
}
