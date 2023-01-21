import Foundation

protocol EmployeesPresenting {
    func presentLoadingIndicator(isRefreshing: Bool)
    func hideLoadingIndicator(isRefreshing: Bool)
    func presentEmployees(_ employees: [Employee])
    func presentError()
}

final class EmployeePresenter {
    weak var view: EmployeesDisplay?
}

extension EmployeePresenter: EmployeesPresenting {
    func presentLoadingIndicator(isRefreshing: Bool) {
        guard !isRefreshing else { return }
        view?.startLoadingAnimation()
    }
    
    func hideLoadingIndicator(isRefreshing: Bool) {
        isRefreshing ? view?.stopRefreshingAnimation() : view?.stopLoadingAnimation()
    }
    
    func presentError() {
        view?.displayError(message: "Error!\nPlease, try again later.")
    }
    
    func presentEmployees(_ employees: [Employee]) {
        if employees.isEmpty {
            view?.displayEmptyState()
            return
        }
        
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
