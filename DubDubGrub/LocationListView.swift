//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 28.10.21.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { item in
                    HStack {
                        Image("default-square-asset")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.vertical, 8)
                        
                        VStack(alignment: .leading) {
                            Text("Test LocationName")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                            
                            HStack {
                                AvertarView()
                                AvertarView()
                                AvertarView()
                                AvertarView()
                                AvertarView()
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
        
    }
}

struct AvertarView: View {
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .clipShape(Circle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
