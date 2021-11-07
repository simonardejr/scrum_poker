//
//  SprintDetailViewController.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol AddSprintViewToPresenter: AnyObject {
    func saveSprint(sprint: Sprint)
}

class AddSprintViewController: UIViewController {

    @IBOutlet weak var sprintName: UITextField!
    
    @IBOutlet weak var sprintLink: UITextField!
    
    var presenter: SprintPresenterToView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Adicionar nova Sprint"

    }

    @IBAction func saveSprint(_ sender: UIButton) {
        print("Save sprint btn")
        
        let sprint = Sprint(id: 0, nome: sprintName.text ?? "", link: sprintLink.text ?? "")
        
        self.saveSprint(sprint: sprint)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddSprintViewController: AddSprintViewToPresenter {
    func saveSprint(sprint: Sprint) {
        self.presenter?.addSprint(sprint: sprint)
    }
}
