import Foundation
import Argo
import Result

public struct APIClient {
  private let requestPerformer: NetworkRequestPerformer

  public init(requestPerformer: NetworkRequestPerformer = NetworkRequestPerformer()) {
    self.requestPerformer = requestPerformer
  }
}

public extension APIClient {
  func performRequest<T: RequestBuilder where T.RequestType: NSURLRequest>(request: T, completionHandler: Result<T.ResponseType, NSError> -> Void) {
    requestPerformer.performRequest(request.build()) { result in
      let object = result >>- deserialize >>- { request.parse($0) }
      completionHandler(object)
    }
  }
}

private func deserialize(response: HTTPResponse) -> Result<JSON, NSError> {
  guard let data = response.data else {
    return .Failure(Result<JSON, NSError>.error("No response data"))
  }

  do {
    let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    return .Success(JSON.parse(object))
  } catch let error as NSError {
    return .Failure(error)
  }
}
