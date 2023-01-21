import Foundation

protocol EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void)
}

final class EmployeesService {
    private enum Endpoint {
        static let employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    }
}

extension EmployeesService: EmployeesServicing {
    func fetchEmployees(completion: @escaping (Result<Employees, NetworkError>) -> Void) {
        guard let url = URL(string: Endpoint.employees) else { return }
        let request = URLRequest(url: url)
        NetworkManager<Employees>().run(request, keyDecodingStrategy: .convertFromSnakeCase) { response in
//            DispatchQueue.main.async {
//                completion(response)
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(.success(Employees(employees: [])))
            }
        }
    }
}
