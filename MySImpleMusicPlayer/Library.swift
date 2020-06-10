//
//  Library.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 10.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct Library: View {
    
    var tracks = UserDefaults.standard.savedTracks()
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            print("DEBUG: 12345")
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9103408456, green: 0.9230595231, blue: 0.9552127719, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            print("DEBUG: 54321")
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9103408456, green: 0.9230595231, blue: 0.9552127719, alpha: 1)))
                                .cornerRadius(10)
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                List(tracks) { track in
                    LibraryCell(cell: track)
                }
            }
                
                .navigationBarTitle("Library")
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            Image("ely_mountain")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
