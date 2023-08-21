//
//  File.swift
//  Assignment_4week
//
//  Created by hoon on 2023/08/16.
//

import UIKit
import SwiftyJSON
import Alamofire


class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func callRequest(number: Int, completionHandler: @escaping (Lotto) -> ()) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: Lotto.self) { response in
                
            guard let value = response.value else { return }
            
            completionHandler(value)
            
        }
    }
}
