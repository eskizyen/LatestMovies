import Foundation

extension Remote {
    
    public class Endpoint: NSObject, URLSessionDelegate {
        let baseRequest = Request()
        
        override init() {
            super.init()
            
            baseRequest.set(session: URLSession(configuration: URLSessionConfiguration.default,
                                                delegate: self,
                                                delegateQueue: nil))
                .set(header: .contentType(.json))
        }
        
        /*
         disable SSL Authentication for proxy while debugging
         */
        #if DEBUG
        public func urlSession(_ session: URLSession,
                               didReceive challenge: URLAuthenticationChallenge,
                               completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        ) {
            guard let trust = challenge.protectionSpace.serverTrust else {
                completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
                return
            }
            
            let credential = URLCredential(trust: trust)
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, credential)
        }
        #endif
    }
    
}
