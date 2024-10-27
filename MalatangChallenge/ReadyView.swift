//
//  ReadyView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/28/24.
//

import SwiftUI

struct ReadyView: View {
  @State private var count = 3
  @State private var isActive = false
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .scaledToFill()
        .frame(alignment: .center)
        .ignoresSafeArea(.all)
      
      VStack {
        if count > 0 {
          Text("\(count)")
            .onAppear{
              startCountDown()
            }
        } else {
          Text("Start!")
        }
      }
      .font(.custom("DNFBitBitv2", size: 90))
      .fullScreenCover(isPresented: $isActive) {
        DancingView()
      }
    }
  }
  
  private func startCountDown() {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      if count > 1 {
        count -= 1
      } else {
        count = 0
        timer.invalidate()
        isActive = true
      }
    }
  }
  
}

#Preview {
  ReadyView()
}
