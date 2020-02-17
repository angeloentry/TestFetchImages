//
//  Request.swift
//  TestFetchImages
//
//  Created by Allen Savio on 2/10/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Request {
    case login
    case getImages(of: String)
    
    
    func execute() -> DataRequest {
        let request: DataRequest
        switch self {
        case .login:
            let url = "https://api.gettyimages.com/oauth2/token".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let _headers : HTTPHeaders = ["Content-Type": "application/json"]
            let params : Parameters = ["grant_type":"client_credentials","client_id":"j878g39yx378pa77djthzzpn","client_secret":"hZJS5A3GJpJvcGhaXwev3kwmq3DgtfcQmEuGbGruQBfsz"]
            request = Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: _headers)
        case .getImages(let searchText):
            let url = "https://api.gettyimages.com/v3/search/images".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let _headers : HTTPHeaders = ["Api-Key": "j878g39yx378pa77djthzzpn", "Accept-Language": "en", "Authorization": Authentication.shared.accessToken]
            let params : Parameters = ["phrase": searchText]
            request = Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: _headers)
        }
        return request
    }
}

extension DataRequest {
    func fetchJSON(success: @escaping (_ data: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        self.validate().responseJSON { (response) in
            DispatchQueue.main.async {
                if let error = response.error {
                    failure(error)
                } else if let data = response.data {
                    do {
                        let json = try JSON(data: data)
                        success(json)
                    } catch let error {
                        failure(error)
                    }
                }
            }
        }
    }
}
