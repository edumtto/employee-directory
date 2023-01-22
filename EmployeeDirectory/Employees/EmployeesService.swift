import Foundation

protocol EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void)
}

final class EmployeesService {
    private enum Endpoint {
        static let employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    }
    
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension EmployeesService: EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void) {
        guard let url = URL(string: Endpoint.employees) else { return }
        let request = URLRequest(url: url)
        
        networkManager.perform(request, keyDecodingStrategy: .convertFromSnakeCase) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
