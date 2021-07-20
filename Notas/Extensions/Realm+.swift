//
//  Realm+.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import RealmSwift
import Foundation
import Combine
import ComposableArchitecture

extension Realm {
    func save<T: Object>(_ type: T.Type, value: [String: Any]) -> Effect<Signal, AppError> {
        let promise = Future<Signal, AppError> { completion in
            do {
                try self.write {
                    self.create(type, value: value, update: .modified)
                }
                completion(.success(.signal))
            } catch {
                completion(.failure(AppError.unableToSave))
            }
        }
        return promise.eraseToEffect()
    }
    
    func create<T: Object>(_ type: T.Type, object: T) -> Effect<Signal, AppError> {
        let promise = Future<Signal, AppError> { completion in
            do {
                try self.write({
                    self.add(object)
                })
                completion(.success(.signal))
            } catch {
                completion(.failure(AppError.unableToCreate))
            }
        }
        return promise.eraseToEffect()
    }
    
    func delete<T: Object>(object: T) -> Effect<Signal, AppError> {
        let promise = Future<Signal, AppError> { completion in
            do {
                try self.write {
                    self.delete(object)
                }
                completion(.success(.signal))
            } catch {
                completion(.failure(AppError.unableToDelete))
            }
        }
        return promise.eraseToEffect()
    }
}
