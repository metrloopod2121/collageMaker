//
//  MainView.swift
//  collageMaker
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 23.12.2024.
//

import Foundation
import SwiftUI
import Photos


struct MainView: View {
    @State private var hasPhotoLibraryAccess = true
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var showCollageView = false
    
    @State private var selectedPhotos: [UIImage] = []

    var body: some View {
        VStack {
            if true {
                Image("collageMakerMainView")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                Text("Make collage right now 🎉")
                    .font(.title)
                Spacer()
                
                DatePicker(
                    "Начальная дата",
                    selection: $startDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(CompactDatePickerStyle())
                .padding(.horizontal)
                
                DatePicker(
                    "Конечная дата",
                    selection: $endDate,
                    in: startDate...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(CompactDatePickerStyle())
                .padding(.horizontal)
                
                Spacer()

                NavigationLink(destination: CollagePreview(photos: selectedPhotos), isActive: $showCollageView) {
                    Button("Создать коллаж") {
                        fetchPhotosForSelectedPeriod()
                        showCollageView = true
                    }
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(15)
                    }
                    .isDetailLink(false) // Отключает вложенный режим для iPadx
                
            } else {
                Text("Доступ к медиатеке не предоставлен!")
                Button("Запросить доступ к медиатеке") {
                    PermissionManager.shared.requestPhotoLibraryAccess { granted in
                        hasPhotoLibraryAccess = granted
                        if !granted {
                            print("Доступ к медиатеке отклонён пользователем.")
                        }
                    }
                }
                .frame(width: 300, height: 50)
                .foregroundStyle(.white)
                .background(.blue)
                .cornerRadius(15)
            }
        }
        .padding()
        .onAppear {
            hasPhotoLibraryAccess = PermissionManager.shared.checkPhotoLibraryAccess()
        }
    }

    func fetchPhotosForSelectedPeriod() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "creationDate >= %@ AND creationDate <= %@", startDate as NSDate, endDate as NSDate)
        
        let assets = PHAsset.fetchAssets(with: fetchOptions)
        
        // Извлекаем изображения из ассетов
        var photos: [UIImage] = []
        assets.enumerateObjects { (asset, _, _) in
            let manager = PHImageManager.default()
            manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil) { (image, _) in
                if let image = image {
                    photos.append(image)
                }
            }
        }
        
        DispatchQueue.main.async {
            selectedPhotos = photos
        }
    }
}

#Preview {
    MainView()
}



