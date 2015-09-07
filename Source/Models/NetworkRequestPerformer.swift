import Foundation
import Result

public struct NetworkRequestPerformer: RequestPerformer {
  public typealias RequestType = NSURLRequest
  public typealias RequestTaskType = NSURLSessionTask
  private let session: NSURLSession

  init(session: NSURLSession = NSURLSession.sharedSession()) {
    self.session = session
  }
}

extension NetworkRequestPerformer {
  public func performRequest(request: RequestBuilderType.RequestType, completionHandler: Result<RequestBuilderType.ResponseType, NSError> -> Void) -> Self.RequestTaskType {
    <#code#>
  }
  
  public func performRequest(request: NSURLRequest, completionHandler: Result<HTTPResponse, NSError> -> Void) -> NSURLSessionTask {
    let task = session.dataTaskWithRequest(request) { data, response, error in
      if let error = error {
        completionHandler(.Failure(error))
      } else {
        let response = HTTPResponse(data: data, response: response)
        completionHandler(.Success(response))
      }
    }
    task.resume()
    return task
  }
}
