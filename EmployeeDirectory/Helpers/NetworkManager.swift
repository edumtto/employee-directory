import Foundation

public enum NetworkError: Error {
    case decodeError(Error)
    case undefinedError(Error)
    case requestError(URLResponse?)
}

//public protocol NetworkManaging {
//    associatedtype ResultType: Decodable
//    func run(
//        _ request: URLRequest,
//        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
//        completion: @escaping ((Result<ResultType, Error>) -> Void)
//    )
//}

public struct NetworkManager<ResultType: Decodable> {
    public let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func run(
        _ request: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping ((Result<ResultType, NetworkError>) -> Void)
    ) {
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(Result.failure(NetworkError.undefinedError(error)))
                return
            }
            
            if let data = data {
                completion(decodeData(data, keyDecodingStrategy: keyDecodingStrategy))
                return
            }
            
            completion(.failure(NetworkError.requestError(response)))
        }
        dataTask.resume()
    }
    
    private func decodeData(
        _ data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    ) -> Result<ResultType, NetworkError> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            let decodedResult = try decoder.decode(ResultType.self, from: data)
            return Result.success(decodedResult)
        } catch {
            // logger.log(error)
            debugPrint(error)
            return Result.failure(NetworkError.decodeError(error))
        }
    }
}
