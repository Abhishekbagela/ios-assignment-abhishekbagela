//
//  ImageView.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 20/04/24.
//

import SwiftUI

struct ImageView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var image: UIImage? = nil
    @State private var error: String? = nil
    
    let size = UIScreen.main.bounds.width / 3 - 15
    
    //INPUTE
    private var model: Model?
    init(_ model: Model?) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            if ((error != nil) || (error?.isEmpty == false)) {
                Text(error!)
                    .foregroundColor(.red)
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .cornerRadius(3)
            } else {
                ProgressView()
                    .frame(width: size, height: size)
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            }
        }
        .onAppear {
            viewModel.getImage(url: model?.coverageURL, name: model?.id) { image, error in
                DispatchQueue.main.async {
                    if let image = image {
                        self.image = image
                    } else {
                        self.error = error
                    }
                }
            }
        }
    }
}

#Preview {
    ImageView(nil)
}
