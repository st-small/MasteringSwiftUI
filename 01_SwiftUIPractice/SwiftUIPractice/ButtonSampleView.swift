//
//  ButtonSampleView.swift
//  SwiftUIPractice
//
//  Created by Stanly Shiyanovskiy on 15.11.2020.
//

import SwiftUI

struct ButtonSampleView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Hello World tapped!")
            }, label: {
                Text("Hello, World!")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.purple, lineWidth: 5)
                    )
            })
            Button(action: {
                print("Delete button tapped!")
            }, label: {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            })
            Button(action: {
                print("Delete button tapped!")
            }, label: {
                Label(
                    title: { Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                    },
                    icon: { Image(systemName: "trash")
                        .font(.title) }
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            })
            Button(action: {
                print("Delete button tapped!")
            }, label: {
                Label(
                    title: { Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                    },
                    icon: { Image(systemName: "trash")
                        .font(.title) }
                )
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .shadow(color: .gray, radius: 20.0, x: 20, y: 10)
            })
            Button(action: {
                print("Delete button tapped!")
            }, label: {
                Label(
                    title: { Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                    },
                    icon: { Image(systemName: "trash")
                        .font(.title) }
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
            })
            
            Button(action: {
                print("Share tapped!")
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up") .font(.title)
                    Text("Share")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())
            Button(action: {
                print("Edit tapped!")
            }) {
                HStack {
                    Image(systemName: "square.and.pencil") .font(.title)
                    Text("Edit")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())
            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())
            Button(action: {
                
            }) {
                Image(systemName: "plus")
                    .font(.system(.largeTitle, design: .rounded))
            }
            .buttonStyle(RotateBackgroundStyle())
            Spacer()
        }
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View { configuration.label
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct RotateBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View { configuration.label
        .padding()
        .foregroundColor(.white)
        .background(Color.purple)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .rotationEffect(configuration.isPressed ? Angle(degrees: 45) : Angle(degrees: 90))
    }
}

struct ButtonSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSampleView()
    }
}
