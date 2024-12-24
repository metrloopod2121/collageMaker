//
//  CollagePreview.swift
//  collageMaker
//
//  Created by 𝕄𝕒𝕥𝕧𝕖𝕪 ℙ𝕠𝕕𝕘𝕠𝕣𝕟𝕚𝕪 on 24.12.2024.
//

import Foundation
import SwiftUI

struct CollagePreview: View {
    @State var photos: [UIImage]
    
    var body: some View {
        Image(uiImage: photos[0])
            .resizable()
            .scaledToFit()
    }
}
