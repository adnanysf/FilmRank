//
//  ContentView.swift
//  FilmRank
//
//  Created by Adnan Yusuf on 1/10/23.
//

import SwiftUI


struct ContentView: View {
    @State private var sheetBool = false
    @State private var movies = [String]()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "camera")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Your Movies")
                List{
                    ForEach(movies.indices, id: \.self){index in Text("\(index+1). \(movies[index])")
                    }.onDelete { IndexSet in
                        movies.remove(atOffsets: IndexSet)
                    }.onMove(perform: {index, newOffset in
                        movies.move(fromOffsets: index, toOffset: newOffset)})
                

                
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarItems(leading:
                                    HStack{
                Text("FilmRank")
            },trailing:
                    HStack {
                Button(action: {
                    self.sheetBool = true
                }) {
                    Image(systemName: "plus")
                }
            }
            )
            .sheet(isPresented: $sheetBool){
                AddMovie(movies: self.$movies, showSheet: self.$sheetBool)
            }
        }
                
    }


}


    struct AddMovie: View{
        @Binding var movies: [String]
        @Binding var showSheet: Bool
        @State private var newMovie = ""
        
        
        var body: some View{
            VStack{
                Spacer()
                Spacer()
                TextField("Enter movie title", text: $newMovie).multilineTextAlignment(.center)
                Spacer()
                HStack{
                    Spacer()
                    Button("Add Movie"){
                        if !self.newMovie.isEmpty{
                            self.movies.append(self.newMovie)
                            self.newMovie = ""
                        }
                    }
                    Spacer()
                    Button("Cancel"){
                        self.showSheet = false
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
            }
            
            
        }
    }
    
    
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
