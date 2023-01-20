import Foundation

protocol EmployeesPresenting {
    func presentLoading()
    func hideLoading()
    func presentEmployees(_ employees: [Employee])
    func presentError()
}

final class EmployeePresenter {
    weak var view: EmployeesDisplay?
}

extension EmployeePresenter: EmployeesPresenting {
    func presentLoading() {
        view?.startLoading()
    }
    
    func hideLoading() {
        view?.stopLoading()
    }
    
    func presentError() {
        view?.displayError()
    }
    
    func presentEmployees(_ employees: [Employee]) {
        let summaries = employees.map { employee in
            EmployeeSummary(
                photoURL: URL(string: employee.photoUrlSmall),
                name: employee.fullName,
                team: employee.team
            )
        }
        view?.displayEmployeeSummaries(summaries)
    }
}
