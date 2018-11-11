//
//  MoyaPlugin.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import Moya

struct MoviePlugins: PluginType {
    public init() {}
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        //initial setup request
        return request
    }
}

protocol MovieTargetType: TargetType {}
extension MovieTargetType {
    private var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie/")!
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
 
}
