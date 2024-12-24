//
//  PhotoManager.swift
//  collageMaker
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 23.12.2024.
//

import Foundation
import Photos

class PhotoManager {
    static let shared = PhotoManager()
    
    private init() {}
    
    func fetchPhotos(forYear year: Int, includeFavorites: Bool, completion: @escaping ([PHAsset]) -> Void) {
        var assets: [PHAsset] = []
        
        // Дата начала и конца года
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: year + 1, month: 1, day: 1))!
        
        // Фильтрация по дате и избранным
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "creationDate >= %@ AND creationDate < %@", startDate as CVarArg, endDate as CVarArg)
        
        if includeFavorites {
            options.predicate = NSPredicate(format: "isFavorite == YES")
        }
        
        // Получаем все фотографии
        let fetchResult = PHAsset.fetchAssets(with: .image, options: options)
        fetchResult.enumerateObjects { (asset, _, _) in
            assets.append(asset)
        }
        
        completion(assets)
    }
}
