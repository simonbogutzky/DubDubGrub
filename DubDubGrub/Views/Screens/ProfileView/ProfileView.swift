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
    @FocusState private var focusedTextField: ProfileTextField?
    
    enum ProfileTextField {
        case firstName, lastName, companyName, bio
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ProfileImageView(image: viewModel.avatar)
                    .onTapGesture { viewModel.isShowingPhotoPicker = true }
                    
                    VStack (spacing: 1) {
                        TextField("First Name", text: $viewModel.firstName)
                            .profileNameStyle()
                            .focused($focusedTextField, equals: .firstName)
                            .onSubmit {
                                focusedTextField = .lastName
                            }
                            .submitLabel(.next)
                        
                        TextField("Last Name", text: $viewModel.lastName)
                            .profileNameStyle()
                            .focused($focusedTextField, equals: .lastName)
                            .onSubmit {
                                focusedTextField = .companyName
                            }
                            .submitLabel(.next)
                        
                        TextField("Company Name", text: $viewModel.companyName)
                            .focused($focusedTextField, equals: .companyName)
                            .onSubmit {
                                focusedTextField = .bio
                            }
                            .submitLabel(.next)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        CharatersRemainView(currentCount: viewModel.bio.count)
                            .accessibilityAddTraits(.isHeader)
                        Spacer()
                        
                        if viewModel.isCheckedIn {
                            Button {
                                viewModel.checkOut()
                            } label: {
                                CheckOutButton()
                            }
                            .disabled(viewModel.isLoading)
                        }
                    }
                    
                    BioTextEditor(text: $viewModel.bio)
                        .focused($focusedTextField, equals: .bio)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.determineButtonAction()
                } label: {
                    DDGButton(title: viewModel.buttonTitle)
                }
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss", action: { focusedTextField = nil })
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(DeviceTypes.isiPhone8Standard ? .inline : .automatic)
        .ignoresSafeArea(.keyboard)
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getCheckedInStatus()
        }
    }
}

fileprivate struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}


fileprivate struct ProfileImageView: View {
    var image: UIImage
    
    var body: some View {
        
        ZStack {
            AvatarView(image: image, size: 84)
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .foregroundColor(.white)
                .offset(y: 30)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("Profile Photo"))
        .accessibilityHint(Text("Opens the iPhone's photo picker"))
        .padding(.leading, 12)
        
        
    }
}


fileprivate struct CharatersRemainView: View {
    
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


fileprivate struct CheckOutButton: View {
    var body: some View {
        Label("Check out", systemImage: "mappin.and.ellipse")
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(10)
            .frame(height: 28)
            .background(Color.grubRed)
            .cornerRadius(8)
            .accessibilityLabel(Text("Check out of current location"))
    }
}


fileprivate struct BioTextEditor: View {
    
    var text: Binding<String>
    
    var body: some View {
        TextEditor(text: text)
            .frame(height: 100)
            .overlay {
RoundedRectangle(cornerRadius: 8) .stroke(Color.secondary, lineWidth: 1) }
            .accessibilityHint(Text("This Textfield has a 100 character maximum"))
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
