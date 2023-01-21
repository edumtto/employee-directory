//
//  EmployeeInteractor.swift
//  EmployeeDirectory
//
//  Created by Eduardo Motta de Oliveira on 1/18/23.
//

import Foundation

protocol EmployeesInteracting {
    func loadEmployees(isRefreshing: Bool)
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
    func loadEmployees(isRefreshing: Bool) {
        presenter.presentLoadingIndicator(isRefreshing: isRefreshing)
        
        service.fetchEmployees { [weak self] result in
            self?.presenter.hideLoadingIndicator(isRefreshing: isRefreshing)
            
            switch result {
            case .success(let response):
                let employees = response.employees
                self?.presenter.presentEmployees(employees)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
}
