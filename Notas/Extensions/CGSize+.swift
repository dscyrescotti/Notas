//
//  CGSize+.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import UIKit

extension CGSize {
    func isPortrait<T>(_ portrait: T, _ landscape: T) -> T {
        width < height ? portrait : landscape
    }
}
