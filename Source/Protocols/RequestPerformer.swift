import Foundation
import Result

public protocol RequestPerformer {
  typealias RequestBuilderType: RequestBuilder
  typealias RequestTaskType
  func performRequest(request: RequestBuilderType.RequestType, completionHandler: Result<RequestBuilderType.ResponseType, NSError> -> Void) -> RequestTaskType
}
