import Foundation

protocol EmployeesPresenting {
    var view: EmployeesDisplay? { get set }
    func presentLoadingIndicator(isRefreshing: Bool)
    func hideLoadingIndicator(isRefreshing: Bool)
    func presentEmployees(_ employees: [Employee])
    func presentError()
}

final class EmployeesPresenter {
    weak var view: EmployeesDisplay?
}

extension EmployeesPresenter: EmployeesPresenting {
    func presentLoadingIndicator(isRefreshing: Bool) {
        guard !isRefreshing else { return }
        view?.startLoadingAnimation()
    }
    
    func hideLoadingIndicator(isRefreshing: Bool) {
        isRefreshing ? view?.stopRefreshingAnimation() : view?.stopLoadingAnimation()
    }
    
    func presentError() {
        view?.displayError(message: "Please, check your connection and try again later.")
    }
    
    func presentEmployees(_ employees: [Employee]) {
        let summaries = employees.map { employee in
            EmployeeSummary(
                photoURL: employee.photoUrlSmall?.url,
                name: employee.fullName,
                team: employee.team
            )
        }
        
        view?.displayEmployeeSummaries(summaries)
        
        if employees.isEmpty {
            view?.displayEmptyState()
        }
    }    
}

private extension String {
    var url: URL? {
        URL(string: self)
    }
}
