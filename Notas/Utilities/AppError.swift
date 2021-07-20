//
//  AppError.swift
//  Notas
//
//  Created by Dscyre Scotti on 20/07/2021.
//

import Foundation

enum AppError: Error {
    case unableToSave
    case unknown
    case unableToCreate
    case unableToDelete
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToSave:
            return NSLocalizedString("Unable to save your changes.", comment: "")
        case .unableToCreate:
            return NSLocalizedString("Unable to create a new note.", comment: "")
        case .unknown:
            return NSLocalizedString("Unable to describe the error.", comment: "")
        case .unableToDelete:
            return NSLocalizedString("Unable to delete the note.", comment: "")
        }
    }
}

extension AppError: Equatable { }
