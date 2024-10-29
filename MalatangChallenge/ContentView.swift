//
//  ContentView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack (path: $appState.navigationPath) {
            ZStack{
                Image("HomeView")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                NavigationLink(destination: LoadingView()) {
                    VStack {
                        Spacer()
                        ZStack(alignment: .center){
                            Rectangle()
                                .foregroundColor(Color(red: 0.98, green: 0.78, blue: 0.78))
                                .frame(width: 240, height: 83.91608)
                                .cornerRadius(167.83217)
                            
                            Text("START")
                                .font(.custom("DNFBitBitv2", size: 30))
                                .foregroundStyle(Color.black)
                        }
                        .padding(.bottom, 307)
                    }
                }
            }
            .navigationDestination(for: Int.self) { score in
                EndingView(score: score)
            }
        }
    }
}
#Preview {
  ContentView()
}
