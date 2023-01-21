import Foundation

enum NetworkError: Error {
    case decode
    case undefined(Error)
    case noData(URLResponse?)
}

struct NetworkManager<ResultType: Decodable> {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func run(
        _ request: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping ((Result<ResultType, NetworkError>) -> Void)
    ) {
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(Result.failure(NetworkError.undefined(error)))
                return
            }
            
            if let data = data {
                completion(decodeData(data, keyDecodingStrategy: keyDecodingStrategy))
                return
            }
            
            completion(.failure(NetworkError.noData(response)))
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
            return Result.failure(NetworkError.decode)
        }
    }
}
