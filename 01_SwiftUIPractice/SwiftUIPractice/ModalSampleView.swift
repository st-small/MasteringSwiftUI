//
//  ModalSampleView.swift
//  SwiftUIPractice
//
//  Created by Stanly Shiyanovskiy on 16.11.2020.
//

import SwiftUI

struct ModalSampleView: View {
    
    //@State var showDetailView = false
    @State var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                ArticleRow(article: article)
                    .onTapGesture {
                        //showDetailView = true
                        selectedArticle = article
                    }
            }
//            .sheet(isPresented: $showDetailView) {
//                if let selectedArticle = selectedArticle {
//                    ArticleDetailView(article: selectedArticle)
//                }
//            }
            
            
//            .sheet(item: $selectedArticle) {
//                ArticleDetailView(article: $0)
//            }
            
            .fullScreenCover(item: $selectedArticle) {
                ArticleDetailView(article: $0)
            }
            
            .navigationBarTitle("Your Reading") }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ModalSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ModalSampleView()
    }
}
