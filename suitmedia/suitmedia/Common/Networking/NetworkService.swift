//
//  NetworkService.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import Alamofire

typealias JsonDict = [String : Any]

enum Response{
    case success(message:String?,response: JsonDict)
    case failureResponse(message:String?,response: JsonDict)
    case failureJson
    case failureError(error: NSError?)
    case failure
    case notConnectedToInternet
}

class NetworkService:NSObject {
    
    ///Add the network logger on the configuration
    var dataRequestArray = [() -> Void]()
    var sessionManager = Alamofire.SessionManager()
    //    //Your custom configuration
    var session: URLSession?
    let configuration = URLSessionConfiguration.default
    //var code and message
    var messages:String?
    
    override init() {
        super.init()
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        sessionManager = Alamofire.SessionManager(configuration:configuration)
        
    }
    
    
      /// This call for method, get (Default),post, put, delete
      ///
      /// - Parameters:
      ///   - endPoint: Endpoit url
      ///   - method: method
      ///   - header: headar
      ///   - params: parameter
      ///   - completion: completion handler
      func callApi(endPoint : String, method : Alamofire.HTTPMethod = .get, params: JsonDict? = [:], completion: @escaping (Response) -> Void) {
          
          self.dataRequestArray.append{ [weak self] in
              self?.requestApi(endPoint: endPoint, method: method, params: params, completion: completion)
              
          }
          
          runFirstIfPossible()
      }
      
      
      func requestApi(endPoint : String, method : Alamofire.HTTPMethod = .get, params: JsonDict? = [:], completion: @escaping (Response) -> Void) {
          
           let url = AppConstants.baseUrl + (endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
              // Display Success Alert
        let header = self.setHeaders()
          
         
          switch method {
              
          case .post:
            self.sessionManager.request(url, method: method, parameters: params, encoding:URLEncoding.httpBody, headers: header).responseJSON(completionHandler: { (response: DataResponse<Any>) in
                self.serializeResponse(response: response, completion: completion)
             })
          
          default:
              
            self.sessionManager.request(url, method: method, parameters: params, headers: header).responseJSON(completionHandler: {
                  (response: DataResponse<Any>) in
                 
                  
                self.serializeResponse(response: response, completion: completion)
             })
              
          }
      
         
      }
    
    
    /// Serialized object of response
    ///
    /// - Parameters:
    ///   - response: Data of response
    ///   - completion: Service Response
    func serializeResponse(response: DataResponse<Any>, completion:@escaping(Response) -> Void) {
        
        guard response.response != nil else {
            if let error = response.result.error as NSError?, error.code ==
                NSURLErrorNotConnectedToInternet{
                self.notConnectedToInternet(completion: completion)
                
            } else {
                
                completion(.failureError(error:response.result.error as NSError? ))
            }
            
            return
        }
        
        guard let jsonResponse = response.result.value as? JsonDict else {
            
            self.failure(completeion: completion)
            return
        }
        
        if response.response?.statusCode != 200{
            
            self.failureResponse(result: jsonResponse, completeion: completion)
            
        }else{
            self.successResult(result: jsonResponse, completion: completion)
            
        }
        
        
    }
    
    
    /// Cancell Request Api
    func cancellAllRequest() {
        self.dataRequestArray.removeAll()
    }
    
    func cancellRequest()  {
        _ = dataRequestArray.remove(at: 0)
        self.runFirstIfPossible()
        
    }
    
    func runFirstIfPossible() {
        if dataRequestArray.count < 1 {return}
        self.dataRequestArray.first?()
    }
    
    /// Not connected to internet function
    ///
    /// - Parameter completion: Service Response
    func notConnectedToInternet(completion:@escaping(Response) -> Void ){
        completion(.notConnectedToInternet)
        self.cancellRequest()
        
    }
    
    
    
    /// Failure Json
    ///
    /// - Parameter completeion: Service Response
    func failure(completeion:@escaping(Response) -> Void) {
        self.cancellRequest()
        completeion(.failure)
        
        
    }
    
    func failureResponse(result: JsonDict?, completeion:@escaping(Response) -> Void) {
        
        guard  let msg =  result!["messages"] as? String  else {
            messages = result!["message"] as? String
            completeion(.failureResponse(message: messages, response: result!))
            self.cancellRequest()
            return
        }
        
        messages = msg
        completeion(.failureResponse(message: messages, response: result!))
        self.cancellRequest()
    }
    
    
    
    // Success API Result Custom
    ///
    /// - Parameters:
    ///   - result: response from API
    ///   - headers: header API
    ///   - completion: Service response
    func successResult(result: JsonDict?, completion:@escaping(Response) -> Void) {
        guard let response = result else {
            completion(.failureJson)
            self.cancellRequest()
            return
        }
        completion(.success(message: "SUCCESS", response: response))
        self.cancellRequest()
        
    }
    
    
    
    // MARK : - Set Header
    /// Get headers
    ///
    /// - Returns: param of headers
    func setHeaders() -> HTTPHeaders {
        
        var headers: HTTPHeaders?
        headers = ["Accept" : "application/json"]
        
        
        return headers!
        
    }

}
