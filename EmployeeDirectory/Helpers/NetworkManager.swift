import Foundation

enum NetworkError: Error {
    case decodeError
    case noContent(URLResponse?)
    case badRequest
    case serverError
    case undefined(Error)
}

protocol NetworkManaging {
    func perform<ResultType: Decodable>(
        _ request: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
        completion: @escaping ((Result<ResultType, NetworkError>) -> Void)
    )
}

struct NetworkManager: NetworkManaging {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func perform<ResultType: Decodable>(
        _ request: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
        completion: @escaping ((Result<ResultType, NetworkError>) -> Void)
    ) {
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                let networkError = mapToNetworkError(response: response, error: error)
                completion(.failure(networkError))
                return
            }
            
            if let data = data {
                do {
                    let decodedData: ResultType = try decodeData(data, keyDecodingStrategy: keyDecodingStrategy)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodeError))
                }
                return
            }
            
            completion(.failure(.noContent(response)))
        }
        dataTask.resume()
    }
    
    private func decodeData<ResultType: Decodable>(
        _ data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    ) throws -> ResultType {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return try decoder.decode(ResultType.self, from: data)
    }
    
    private func mapToNetworkError(response: URLResponse?, error: Error) -> NetworkError {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return .undefined(error)
        }

        switch statusCode {
        case 400..<500:
            return .badRequest
        case 500..<600:
            return .serverError
        default:
            return .undefined(error)
        }
    }
}
