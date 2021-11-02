//
//  OnboardView.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import SwiftUI

struct OnboardView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack (alignment: .leading, spacing: 32) {
                OnboadViewInfoView(imageName: "building.2.crop.circle", title: "Restaurant Locations", description: "Find places to dine around the convention center")
                
                OnboadViewInfoView(imageName: "checkmark.circle", title: "Check In", description: "Let other iOS Devs know where are")
                
                OnboadViewInfoView(imageName: "person.2.circle", title: "Find Friends", description: "See where other iOS Devs are and join the party")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

fileprivate struct OnboadViewInfoView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack (spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}
