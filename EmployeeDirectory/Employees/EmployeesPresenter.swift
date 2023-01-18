//
//  EmployeePresenter.swift
//  EmployeeDirectory
//
//  Created by Eduardo Motta de Oliveira on 1/18/23.
//

import Foundation

protocol EmployeesPresenting {
    
}

final class EmployeePresenter {
    weak var view: EmployeesDisplay?
}

extension EmployeePresenter: EmployeesPresenting {
    
}
