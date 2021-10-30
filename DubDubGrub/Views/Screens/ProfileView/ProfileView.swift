//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 28.10.21.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    NameBackgroundView()
                    
                    HStack {
                        ZStack {
                            AvatarView(image: viewModel.avatar, size: 84)
                            EditImageView()
                        }
                        .padding(.leading, 12)
                        .onTapGesture { viewModel.isShowingPhotoPicker = true }
                        
                        VStack (spacing: 1) {
                            TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                            
                            TextField("Last Name", text: $viewModel.lastName).profileNameStyle()
                            
                            TextField("Company Name", text: $viewModel.companyName)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    CharatersRemainView(currentCount: viewModel.bio.count)
                    
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondary, lineWidth: 1))
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .padding(.bottom)
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
        }
        .onAppear {
            viewModel.getProfile()
        }
    }
}

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImageView: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

struct CharatersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
        
        +
        Text(" Characters Remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
