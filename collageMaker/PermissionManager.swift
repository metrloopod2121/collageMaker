//
//  PermissionManager.swift
//  collageMaker
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 23.12.2024.
//

import Foundation
import Photos

class PermissionManager {
    static let shared = PermissionManager()
    
    private init () {}
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        case .authorized, .limited:
            completion(true)
        default:
            completion(false)
        }
        
    }
    
    func checkPhotoLibraryAccess() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return status == .authorized || status == .limited
    }
}
