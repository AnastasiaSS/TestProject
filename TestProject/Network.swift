//
//  Network.swift
//  TestProject
//
//  Created by Анастасия Соколан on 03.02.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation

import Foundation
import Moya

enum YandexServerAPI {
    case getLangs(ui: String)
    case detect(text: String, hint: [String])
    case translate(text: String, lang: String)
}

extension YandexServerAPI: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    
    var baseURL: URL { return URL(string: "https://translate.yandex.net/api/v1.5/tr.json")! }
    
    var path: String {
        switch self {
        case .getLangs:
            return "/getLangs"
        case .detect:
            return "/detect"
        case .translate:
            return "/translate"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        switch self {
        case YandexServerAPI.getLangs(let ui):
            return ["ui" : ui]
        case YandexServerAPI.detect(let hint):
            return ["hint" : hint.hint.joined(separator: ",")]
        case YandexServerAPI.translate(_, let lang):
            return ["lang" : lang]
        }
    }
    
    var task: Task {
        switch self {
        case .getLangs:
            return .requestParameters(parameters: ["key" : NetworkManager.YandexAPIKey], encoding: URLEncoding.default)
        case .detect(let text, _), .translate(let text, _):
            return .requestParameters(parameters: ["key" : NetworkManager.YandexAPIKey, "text" : text], encoding: URLEncoding.default)
        }
    }
    //use for unit tests - unit tests in progress
    var sampleData: Data {
        return Data()
    }
}

protocol Networkable {
    var provider: MoyaProvider<YandexServerAPI> { get }
    
}

struct NetworkManager: Networkable {
    var provider = MoyaProvider<YandexServerAPI>()
    
    let errorMap: [Int : String] = [
        401 : "Invalid API key",
        402 : "API key is locked",
        404 : "Daily limit on translated text exceeded",
        413 : "Maximum text size exceeded",
        422 : "Text cannot be translated",
        501 : "Specified translation direction is not supported"
    ]
    static let YandexAPIKey = "trnsl.1.1.20190202T191857Z.5ad2a1996820660f.0c3cd412939e9a9883739d26088ae0af1abf76f9"
    
    static func request(target: YandexServerAPI) {
        let prov = MoyaProvider<YandexServerAPI>()
        prov.request(target) { (result) in
            switch result {
            case .success(let response):
                print("SUCCESS!!!")
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    print("Status Code: \(response.statusCode)")
                    switch target {
                    case .detect:
                        break;
                    case .translate:
                        if let obj = try? response.map(TranslatedText.self) {
                            print("Decoded successfully!")
                            if let text = obj.text {
                                print("Get text: \(text)")
                            }
                        }
                        break;
                    case .getLangs:
                        if let obj = try? response.map(Interes.self) {
                            print("Decoded successfully!")
                            if let _ = obj.langs {
                                print("Get langs")
                            }
                        }
                        break;
                    }
                }
                else {
                    print("ANOTHER ERROR")
                }
            case .failure(_):
                print("FAIL")
            }
        }
    }
}

struct DetectedLang: Codable {
    var code: Int
    var lang: String
}

struct TranslatedText: Codable {
    var code: Int?
    var lang: String?
    var text: [String]?
}

struct ErrorType : Codable {
    var code: Int
    var message: String
}

struct Interes: Codable {
    var dirs: [String]?
    var langs: Dictionary<String, String>? //[String: String]?
    var code: Int?
    var text: String?
}
