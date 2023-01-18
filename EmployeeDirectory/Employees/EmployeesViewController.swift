//
//  EmployeeViewController.swift
//  EmployeeDirectory
//
//  Created by Eduardo Motta de Oliveira on 1/18/23.
//

import Foundation
import UIKit

protocol EmployeesDisplay: AnyObject {
    
}

final class EmployeesViewController: UIViewController {
    private let interactor: EmployeesInteracting
    
    init(interactor: EmployeesInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EmployeesViewController: EmployeesDisplay {
    
}
