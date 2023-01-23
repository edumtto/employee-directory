import Foundation
import UIKit

enum EmployeesBuilder {
    static func build() -> UIViewController {
        let presenter = EmployeesPresenter()
        let service = EmployeesService(networkManager: NetworkManager())
        let interactor = EmployeesInteractor(presenter: presenter, service: service)
        let viewController = EmployeesViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
}
