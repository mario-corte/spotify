//
//  ProfileDetailHeaderView.swift
//  MAKS
//
//  Created by Mario Corte on 1/15/24.
//

import SwiftUI

struct ProfileDetailHeaderView: View {
    var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: viewModel.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .tint(.accentColor)
                }
                .frame(width: 100, height: 100)
                .background(.gray)
                .clipShape(.circle)
                VStack(alignment: .leading) {
                    Text(viewModel.name)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    Text(viewModel.id)
                        .foregroundColor(.accent)
                        .font(.footnote)
                        .bold()
                }
                .padding()
            }
            Text(viewModel.email)
                .foregroundColor(.white)
                .font(.subheadline)
                .bold()
                .padding(.top, 10)
            Text("\(String(viewModel.followers)) followers")
                .foregroundColor(.white)
                .font(.footnote)
                .bold()
                .padding(.bottom, 10)
        }
    }
}
