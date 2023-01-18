//
//  EmployeesBuilder.swift
//  EmployeeDirectory
//
//  Created by Eduardo Motta de Oliveira on 1/18/23.
//

import Foundation
import UIKit

enum EmployeesBuilder {
    static func build() -> UIViewController {
        let presenter = EmployeePresenter()
        let service = EmployeesService()
        let interactor = EmployeesInteractor(presenter: presenter, service: service)
        let viewController = EmployeesViewController(interactor: interactor)
        return viewController
    }
}
