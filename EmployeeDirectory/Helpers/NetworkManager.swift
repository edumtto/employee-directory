import Foundation

enum NetworkError: Error {
    case decode
    case undefined(Error)
    case noData(URLResponse?)
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
                // TODO: Categorize different errors
                completion(.failure(NetworkError.undefined(error)))
                return
            }
            
            if let data = data {
                do {
                    let decodedData: ResultType = try decodeData(data, keyDecodingStrategy: keyDecodingStrategy)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decode))
                }
                return
            }
            
            completion(.failure(.noData(response)))
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
}
