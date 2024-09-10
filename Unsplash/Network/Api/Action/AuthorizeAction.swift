import Foundation
import UIKit
import Alamofire

class AuthorizeAction {
    private static var requestCodeUrl: String {
        let scopes = ["public", "read_user", "write_user", "read_photos", "write_photos", "write_likes", "write_followers", "read_collections", "write_collections"]
        let accessKey = ProcessInfo.processInfo.environment["ACCESS_KEY"] ?? ""
        let params: [String:String] = [
            "client_id": accessKey,
            "redirect_uri": "unsplash://",
            "response_type": "code",
            "scope": scopes.joined(separator: "+")
        ]
        let queryParams = params.map { "\($0)=\($1)" }.joined(separator: "&")
        return "https://unsplash.com/oauth/authorize?\(queryParams)"
    }
    
    static func requestCode(){
        if let url = URL(string: requestCodeUrl){
            UIApplication.shared.open(url)
        }
    }
    
    static func urlCodeHandler(url: URL) -> String?{
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        guard let queryItems = components.queryItems else { return nil }
        for item in queryItems {
            if(item.name == "code"){
                return item.value
            }
        }
        return nil
    }
    
    static func requestToken(code: String, completion: @escaping RequestCompletion<LoginResult>){
        guard let accessKey = ProcessInfo.processInfo.environment["ACCESS_KEY"] else {
            return
        }
        guard let secretKey = ProcessInfo.processInfo.environment["SECRET_KEY"] else {
            return
        }
        
        AF.request(
            "https://unsplash.com/oauth/token",
            method: .post,
            parameters: [
                "client_id": accessKey,
                "client_secret": secretKey,
                "redirect_uri":"unsplash://",
                "code": code,
                "grant_type": "authorization_code"
            ]
        )
        .responseDecodable(of: LoginResult.self) { response in
            completion(response.result)
        }
    }
}
