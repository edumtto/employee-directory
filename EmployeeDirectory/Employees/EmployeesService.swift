import Foundation

protocol EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void)
}

final class EmployeesService {
}

extension EmployeesService: EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void) {
        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json") else { return }
        let request = URLRequest(url: url)
        NetworkManager<Employees>().run(request, keyDecodingStrategy: .convertFromSnakeCase) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
