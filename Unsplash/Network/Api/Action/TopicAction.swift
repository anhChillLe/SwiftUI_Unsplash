import Foundation
import Alamofire

extension Topic {
    static func list(ids: [String]? = nil, page: Int = 1, perPage: Int = 20, orderBy: OrderBy = .lastest, completion: @escaping (Result<[Topic], AFError>) -> Void){
        var parameters: Parameters = [
            "page" : page,
            "per_page" : perPage,
            "order_by" : orderBy.rawValue
        ]
        
        if let ids {
            parameters.updateValue(ids.joined(separator: ","), forKey: "ids")
        }
        
        ApiClient.shared.request(
            "/topics",
            parameters: parameters,
            completion: completion
        )
    }
    
    func listPhoto(page: Int? = nil, perPage: Int? = nil, orientation: Orientation? = nil, orderBy: OrderBy? = nil, completion: @escaping RequestCompletion<[Photo]>){
        var params: Parameters = [:]
        if let page {
            params.updateValue(page, forKey: "page")
        }
        if let perPage {
            params.updateValue(perPage, forKey: "per_page")
        }
        if let orientation {
            params.updateValue(orientation, forKey: "orientation")
        }
        if let orderBy {
            params.updateValue(orderBy, forKey: "order_by")
        }
        
        ApiClient.shared.request(
            "/topics/\(id)/photos",
            parameters: params,
            completion: completion
        )
    }
}
