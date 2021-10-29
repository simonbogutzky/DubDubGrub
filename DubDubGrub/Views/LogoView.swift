//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import SwiftUI

struct LogoView: View {
    
    var frameWidth: Double
    
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: frameWidth)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
