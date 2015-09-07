struct HTTPRequest: RequestBuilder {
  typealias RequestType = NSURLRequest
  typealias ResponseType = HTTPResponse
  
  func build() -> HTTPRequest.RequestType {
    
  }
}