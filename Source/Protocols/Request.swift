import Foundation
import Argo
import Result

public protocol RequestBuilder {
  typealias RequestType
  typealias ResponseType
  func build() -> RequestType
  func parse(j: JSON) -> Result<ResponseType, NSError>
}

public extension RequestBuilder where ResponseType: Decodable, ResponseType.DecodedType == ResponseType {
  func parse(j: JSON) -> Result<ResponseType, NSError> {
    return .fromDecoded(ResponseType.decode(j))
  }
}
