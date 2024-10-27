//
//  LoadingView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/28/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
      ZStack{
        Color.black
          .ignoresSafeArea(.all)
        
        VStack {
          Text("과연 루시드에게")
            .font(.custom("DNFBitBitv2", size: 37))
            .foregroundStyle(Color.white)
            .padding(.bottom, 30)
          
          VStack{
            HStack(spacing: 0) {
              Text("마라탕")
                .foregroundStyle(Color(red: 244/255, green: 67/255, blue: 67/255))
              Text("과 ")
                .foregroundStyle(Color.white)
              Text("탕후루")
                .foregroundStyle(Color(red: 116/255, green: 213/255, blue: 101/255))
              Text("를")
                .foregroundStyle(Color.white)
            }
            Text("얻어먹을 수 있을까?")
              .foregroundStyle(Color.white)
          }
          .font(.custom("DNFBitBitv2", size: 20))
          .padding(.bottom, 277)
          
          Text("Tip:\n루시드의 동작을 완벽하게 따라할수록 점수가 올라요!")
            .font(.custom("DNFBitBitv2", size: 15))
            .foregroundStyle(Color(red: 255/255, green: 245/255, blue: 157/255))
            
        }
        
        Image("마라탕")
          .resizable()
          .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    LoadingView()
}
