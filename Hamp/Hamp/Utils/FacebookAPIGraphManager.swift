//
//  FacebookAPIGraphManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit
import FacebookLogin
import FacebookCore

public struct FacebookAPIManager {
    
    /// Login with facebook sdk
    /// · LoginManager
    /// · Graph API
    ///
    /// - Parameters:
    ///    viewController to present the login view
    ///   - onSuccess: called if all was successfully
    ///   - onError: called if an error occurred
    static func logIn(onViewController viewController: UIViewController,
                      onSuccess: ((HampUser, AccessToken) -> ())? = nil,
                      onError: ((Error) -> ())? = nil) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userBirthday],
                           viewController: viewController) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                onError?(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, let accessToken):
                self.retrieveHampUserFromFacebookInformation(with: accessToken, onSuccess: { (user) in
                    onSuccess?(user, accessToken)
                }, onError: onError)
            }
        }
    }
    
    /// Retrieve user information from facebook API Graph
    ///
    /// - Parameter token: Facebook token got from sigin
    private static func retrieveHampUserFromFacebookInformation(with token: AccessToken,
                                                                onSuccess: ((HampUser) -> ())? = nil,
                                                                onError: ((Error) -> ())? = nil) {
        let req = GraphRequest(graphPath: "me",
                               parameters: ["fields": "email, name, first_name, last_name, birthday, gender"],
                               accessToken: token,
                               httpMethod: .GET,
                               apiVersion: .defaultVersion)
        req.start({ (reqResponse, reqResult) in
            switch reqResult {
            case .success(let reqResultResponse):
                onSuccess?(self.user(byFacebookResponse: reqResultResponse.dictionaryValue))
            case .failed(let reqResultError):
                onError?(reqResultError)
            }
        })
    }
    
    /// Create user from facebook response dictionary of values
    ///
    /// - Parameter dictionaryValue: facebook dictionary of values
    /// - Returns: User created from values of the dictionary
    private static func user(byFacebookResponse dictionaryValue: [String: Any]?) -> HampUser {
        let name = (dictionaryValue?["first_name"] as? String) ?? ""
        let surname = dictionaryValue?["last_name"] as? String ?? ""
        let mail = dictionaryValue?["email"] as? String ?? ""
        let phone = "666666666"
        let birthday = dictionaryValue?["birthday"] as? String
        var gender: String? = nil
        if let g = dictionaryValue?["gender"] as? String {
            gender = (g == "male" ? "M" : "F")
        }
        
        let user = try! HampUser(identifier: nil, name: name, surname: surname, mail: mail, phone: phone, birthday: birthday, gender: gender, tokenFCM: "123", language: "ca-ES", OS: "iOS", signupDate: nil)
        return user
    }
}
