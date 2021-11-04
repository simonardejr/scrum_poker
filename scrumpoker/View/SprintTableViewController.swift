//
//  SprintTableViewController.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa

protocol SprintViewToPresenter: AnyObject {
    var sprintObserver: Observable<Sprint> { get }
    func setLoading(_ loading: Bool)
    func showSprints(sprints: [Sprint])
}

class SprintTableViewController: UITableViewController {
    
    var sprintBehavior = BehaviorRelay<Sprint?>(value: nil)
    var presenter: SprintPresenterToView!
    let disposeBag = DisposeBag()
    
    private var sprints: [Sprint] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sprints.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sprint = sprints[indexPath.row]
        cell.textLabel?.text = sprint.nome
        cell.detailTextLabel?.text = sprint.link
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] action, view, completion in
                if self?.sprints[indexPath.row].id != nil {
                    print(self!.sprints[indexPath.row].id)
                    self?.presenter.deleteSprint(by: self!.sprints[indexPath.row].id)
                    completion(true)
                }
            }
            action.backgroundColor = .red
            
            return UISwipeActionsConfiguration(actions: [action])
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sprint = sprints[indexPath.row]
        print(sprint)
        tableView.deselectRow(at: indexPath, animated: true)
        showSprintDetail(sprint: sprint)
    }

    private func showSprintDetail(sprint: Sprint) {
        /*let alert = UIAlertController(
            title: "Detalhes da Sprint",
            message: "\nNome: \(sprint.nome) \n\nLink: \(sprint.link)", preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)*/
        
        let alert = UIAlertController(title: "\(sprint.nome)", message: "\(sprint.link)", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Editar", style: .default , handler: { (UIAlertAction) in
                print("Edit button")
            }))

            alert.addAction(UIAlertAction(title: "Deletar", style: .destructive , handler: { (UIAlertAction) in
                self.presenter.deleteSprint(by: sprint.id)
            }))
            
            alert.addAction(UIAlertAction(title: "Fechar", style: .cancel, handler: { (UIAlertAction) in
                print("Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                // acao para ser executada quando fechar o popup, indepentende da acao escolhida
            })
    }
}

extension SprintTableViewController: SprintViewToPresenter {
    var sprintObserver: Observable<Sprint> {
        return sprintBehavior.unwrap().asObservable()
    }
    
    func showSprints(sprints: [Sprint]) {
        self.sprints = sprints
    }
    
    func setLoading(_ loading: Bool) {
        /*if loading {
            self.activityIndicatorLarge.startAnimating()
        } else {
            self.activityIndicatorLarge.stopAnimating()
        }*/
    }
}
