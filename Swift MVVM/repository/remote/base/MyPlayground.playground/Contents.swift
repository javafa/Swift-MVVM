import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct Request {
    var method: HTTPMethod = .GET
    var path: String
    var contentType: String = "application/json"
    var body: [String: Any]?
    var headers: [String: String]?
    typealias ReturnType = Codable
}

@propertyWrapper
struct Switro {
    private var request: Request
    init(_ method: HTTPMethod,_ url:String) { // body:[String: Any]?=nil, headers: [String: String]?=nil
        self.request = Request(method:method, path: "/users")
    }
    
    var wrappedValue: Request {
        get {
            request
        }
        set {
            request = newValue
        }
    }
}

struct TestApi {
    @Switro(HTTPMethod.GET, "/users")
    var request:Request
}




let api = TestApi()
print(api.request.path)
