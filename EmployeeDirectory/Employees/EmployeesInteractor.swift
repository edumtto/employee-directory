//
//  EmployeeInteractor.swift
//  EmployeeDirectory
//
//  Created by Eduardo Motta de Oliveira on 1/18/23.
//

import Foundation

protocol EmployeesInteracting {
    
}

final class EmployeesInteractor {
    private let presenter: EmployeesPresenting
    private let service: EmployeesServicing
    
    init(presenter: EmployeesPresenting, service: EmployeesServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension EmployeesInteractor: EmployeesInteracting {
    
}
