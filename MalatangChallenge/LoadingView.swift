//
//  LoadingView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/28/24.
//

import SwiftUI

struct LoadingView: View {
  @State private var imageIndex = 0
  @State private var navigateToReadyView = false
  private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
  private let images = ["마라탕", "탕후루"]
  
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
        
        Image(images[imageIndex])
          .resizable()
          .frame(width: 100, height: 100)
          .onReceive(timer) { _ in
            imageIndex = (imageIndex + 1) % 2 // 0.5초마다 이미지 변경되도록
          }
      }
    
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        navigateToReadyView = true
      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationDestination(isPresented: $navigateToReadyView) {
      ReadyView()
    }
  }
}

#Preview {
  LoadingView()
}
