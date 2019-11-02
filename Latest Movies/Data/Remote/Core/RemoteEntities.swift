import Foundation

extension Remote {
    enum HttpMethod: String {
        case get
        case post
        case delete
    }
    
    enum ContentType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded"
    }
    
    enum HttpHeader {
        case contentType(ContentType)
        case authorization(String)

        func pair() -> (key: String, value: String) {
            switch self {
            case .contentType(let value):
                return (key: "content-type", value: value.rawValue)
            case .authorization(let token):
                return (key: "authorization", value: token)
            }
        }
    }
}

extension Remote.HttpHeader: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pair().key)
    }
    
    static func == (lhs: Remote.HttpHeader, rhs: Remote.HttpHeader) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
