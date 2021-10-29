//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 28.10.21.
//

import SwiftUI

struct AvatarView: View {
    
    var image: UIImage
    var size: Double
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: PlaceholderImage.avatar, size: 90)
    }
}
