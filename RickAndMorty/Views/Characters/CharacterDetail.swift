//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import SwiftUI

struct CharacterDetail: View {
    @Environment(\.dismiss) var dismiss
    let character: Character
    var body: some View {
        ScrollView {
            CachedAsyncImage(url: character.imageUrl()) { phase in
                switch phase {
                case .empty:
                        Color("SteelBlue")
                            .opacity(0.3)
                            .frame(height: 350)
                case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 350)
                            .clipped()
                default:
                        Image(systemName: "xmark.icloud")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 350)
                            .clipped()
                        }
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                if !character.type.isEmpty {
                    Text(character.type)
                        .font(.system(size: 12, weight: .light, design: .monospaced))
                        .italic()
                }
                HStack {
                    Text(character.status.rawValue)
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(statusColor(character.status))
                    Text("\(character.species) - \(character.gender.text())")
                    Spacer()
                }
                .font(.title2)
                HStack{
                    Text("Origin")
                        .fontWeight(.bold)
                    Text("\(character.origin?.name ?? "unkown")")
                }
                HStack{
                    Text("Location")
                        .fontWeight(.bold)
                    Text("\(character.location?.name ?? "unkown")")
                }
                HStack{
                    Text("Episodes")
                        .fontWeight(.bold)
                    Text("\(character.episodes.count)")
                }
            }.padding()
        }
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color("BabyPownder"))
                }
            }
        }
    }

    func statusColor(_ status: Character.Status) -> Color {
      switch status {
      case .alive: return Color("GreenPigment")
      case .dead: return .black
      default: return Color("SteelBlue")
      }
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: TestData().characters[0])
    }
}
