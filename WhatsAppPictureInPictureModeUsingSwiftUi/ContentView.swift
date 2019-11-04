//
//  ContentView.swift
//  WhatsAppPictureInPictureModeUsingSwiftUi
//
//  Created by ramil on 04.11.2019.
//  Copyright © 2019 com.ri. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {

    @State var height: CGFloat = 0
    @State var show = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                Button(action: {
                    self.show.toggle()
                    self.height = 0
                }) {
                    Text("Picture in Play")
                }
                
                if self.show {
                    
                    player()
                        .frame(height: geo.size.height / 3)
                        .cornerRadius(20)
                        .padding()
                        .gesture(DragGesture()
                            .onChanged({(value) in
                                
                                self.height += value.translation.height / 10
                            })
                            .onEnded({(value) in
                                
                                if self.height > geo.size.height / 2 - 100 {
                                    self.height = 1500
                                    self.show.toggle()
                                }
                                if -self.height > geo.size.height / 2 - 100 {
                                    self.height = -1500
                                    self.show.toggle()
                                }
                            })
                    ).offset(y: self.height)
                }
            }
             
        }.animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct player: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
       
        let controller = AVPlayerViewController()
        let player1 = AVPlayer(url: URL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!)
        controller.player = player1
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
        
    }
}
