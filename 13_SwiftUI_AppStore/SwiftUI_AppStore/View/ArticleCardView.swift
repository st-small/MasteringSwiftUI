//
//  ArticleCardView.swift
//  SwiftUI_AppStore
//
//  Created by Stanly Shiyanovskiy on 02.12.2020.
//

import SwiftUI

struct ArticleCardView: View {
    
    let category: String
    let headline: String
    let subHeadline: String
    let image: UIImage
    var content: String = ""
    
    @Binding var isShowContent: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: isShowContent ? geometry.size.height * 0.7 : min(image.size.height / 3, 500))
                            .border(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), width: isShowContent ? 0 : 1)
                            .cornerRadius(15)
                            .overlay(
                                ArticleExcerptView(category: category,
                                                   headline: headline,
                                                   subHeadline: subHeadline,
                                                   isShowContent: $isShowContent)
                                    .cornerRadius(isShowContent ? 0 : 15)
                            )
                        
                        // Content
                        if isShowContent {
                            Text(content)
                                .foregroundColor(Color(.darkGray))
                                .font(.system(.body, design: .rounded))
                                .padding(.horizontal)
                                .padding(.bottom, 50)
                                .transition(.move(edge: .top))
                                .animation(.linear)
                        }
                    }
                }
                .shadow(color: Color(.sRGB, red: 64/255, green: 64/255, blue: 64/255, opacity: 0.3), radius: isShowContent ? 0 : 15)
                
                if isShowContent {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isShowContent = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.trailing)
                }
            }
        }
    }
}

struct ArticleCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticleCardView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, image: sampleArticles[0].image, isShowContent: .constant(false))
            
            ArticleCardView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, image: sampleArticles[0].image, isShowContent: .constant(true))
        }
    }
}

struct ArticleExcerptView: View {
    
    let category: String
    let headline: String
    let subHeadline: String
    
    @Binding var isShowContent: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            Rectangle()
                .frame(minHeight: 100, maxHeight: 150)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(category.uppercased())
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            Text(headline)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .minimumScaleFactor(0.1)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            
                            if !isShowContent {
                                Text(subHeadline)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(3)
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                )
        }
        .foregroundColor(.white)
    }
}

struct ArticleExcerptView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticleExcerptView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, isShowContent: .constant(false)).previewLayout(.fixed(width: 380, height: 500))
            
            ArticleExcerptView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, isShowContent: .constant(true)).previewLayout(.fixed(width: 380, height: 500))
        }
    }
}
