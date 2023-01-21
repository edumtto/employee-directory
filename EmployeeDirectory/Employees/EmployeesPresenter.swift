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
        view?.displayError(message: "Error!\nPlease, try again later.")
    }
    
    func presentEmployees(_ employees: [Employee]) {
        if employees.isEmpty {
            view?.displayEmptyState()
            return
        }
        
        let summaries = employees.map { employee in
            EmployeeSummary(
                photoURL: employee.photoUrlSmall?.url,
                name: employee.fullName,
                team: employee.team
            )
        }
        
        view?.displayEmployeeSummaries(summaries)
    }    
}

private extension String {
    var url: URL? {
        URL(string: self)
    }
}
