//
//  Library.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 10.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDeleggate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            print("DEBUG: 12345")
                            self.track = self.tracks[0]
                            self.tabBarDeleggate?.maximazedTrackDetailController(viewModel: self.track)
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9103408456, green: 0.9230595231, blue: 0.9552127719, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
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
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded({ _ in
                                    print("DEBUG: Pressed..")
                                    self.track = track
                                    self.showAlert = true
                                })
                                .simultaneously(with: TapGesture()
                                    .onEnded({ _ in
                                        let keyWindow = UIApplication.shared.connectedScenes
                                            .filter({$0.activationState == .foregroundActive})
                                            .map({$0 as? UIWindowScene})
                                            .compactMap({$0})
                                            .first?.windows
                                            .filter({$0.isKeyWindow}).first
                                        
                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        
                                        self.track = track
                                        self.tabBarDeleggate?.maximazedTrackDetailController(viewModel: self.track)
                                    })))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showAlert, content: {
                ActionSheet(title: Text("Are you shure want to delete this Track?"), buttons: [.destructive(Text("Delete"), action: {
                    print("DEBUG: Delete - \(self.track.trackName)")
                    self.delete(track: self.track)
                }), .cancel()
                ])
            })
                .navigationBarTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!).frame(width: 60, height: 60).cornerRadius(2)
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

extension Library: TrackMovingDelegate {
    func moveBackwarForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}
