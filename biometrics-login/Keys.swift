//
//  Keys.swift
//  biometrics-login
//
//  Created by Woranittha Zunseng on 23/3/2564 BE.
//

import Foundation
import Defaults

extension Defaults.Keys {
    static let isLogin = Key<Bool>("isLogin", default: false)
    static let isActiveBiometric = Key<Bool>("isActiveBiometric", default: false)
}
