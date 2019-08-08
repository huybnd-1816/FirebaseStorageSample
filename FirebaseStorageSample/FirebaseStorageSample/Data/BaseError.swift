//
//  BaseError.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 8/8/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum ErrorMessage: String {
    case objectNotFound = "File doesn't exist"
    case unauthorized = "User doesn't have permission to access file"
    case cancelled = "User canceled the upload"
    case unknown = "Unknown error occurred, inspect the server response"
    case defaultErr = "A separate error occurred. This is a good place to retry the upload."
}

enum BaseError: Error {
    case objectNotFound
    case unauthorized
    case cancelled
    case unknown
    case defaultErr
    
    var errorMessage: String? {
        switch self {
        case .objectNotFound:
            return ErrorMessage.objectNotFound.rawValue
        case .unauthorized:
            return ErrorMessage.unauthorized.rawValue
        case .cancelled:
            return ErrorMessage.cancelled.rawValue
        case .unknown:
            return ErrorMessage.unknown.rawValue
        case .defaultErr:
            return ErrorMessage.defaultErr.rawValue
        }
    }
}
