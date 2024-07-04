//
//  ContentView.swift
//  Day60MilestoneProject
//
//  Created by Bruno Oliveira on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var message = ""
    @State private var showingAlert = false
    
    let str = """
    {
        "first_name": "Bruno",
        "last_name": "Oliveira"
    }
    """
    
    let str2 = """
    {
        "first": "Bruno",
        "last": "Oliveira"
    }
    """
    
    let str3 = """
    {
        "first": "Bruno",
        "last": "Oliveira",
        "age": "35"
    }
    """
    
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Decode & Encode Strategys")
                .font(.title)
        }
        .padding()
        
        VStack {
            Button("Different Naming Style Error") {
                message = decodeErrorWithDifferentNamingStyles()
                showingAlert.toggle()
            }
            
            Button("Using Decoding Strategy") {
                message = usingDecodingStrategy()
                showingAlert.toggle()
            }
            
            Button("Using Coding Keys Strategy") {
                message = usingCodingKeysStrategy()
                showingAlert.toggle()
            }
            
            Button("Using Custom Codable Strategy") {
                message = usingCustomCodableStrategy()
                showingAlert.toggle()
            }
            
        }
        .padding(.horizontal,50)
        .alert("Alert!", isPresented: $showingAlert) {
            Button ("Ok") {}
        } message: {
            Text(message)
        }
    }
    
    func decodeErrorWithDifferentNamingStyles() -> String {
        //this will throw an error, becouse the naming styles of JSON and the Swift Struct is different.
        let data = Data(str.utf8)
        
        do {
            let decoder = JSONDecoder()
            
            let user = try decoder.decode(User.self, from: data)
            return "Hi, I'm \(user.firstName) \(user.lastName)"
        } catch {
            return "Whoops: \(error.localizedDescription)"
        }
    }
    
    func usingDecodingStrategy() -> String {
        let data = Data(str.utf8)

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            ///Idem to encode:
            /*let endoer = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            */
            
            let user = try decoder.decode(User.self, from: data)
            return "Hi, I'm \(user.firstName) \(user.lastName)"
        } catch {
            return "Whoop: \(error.localizedDescription)"
        }
    }
    
    func usingCodingKeysStrategy() -> String {
        let data = Data(str2.utf8)
        
        do {
            let decoder = JSONDecoder()
            let userCoding  = try decoder.decode(UserWithCodingKeys.self, from: data)
            print(userCoding)
            return "Hi, I'm \(userCoding.firstName) \(userCoding.lastName)"
        } catch {
            return "Whoops: \(error.localizedDescription)"
        }
    }
    
    func usingCustomCodableStrategy() -> String {
        let data = Data(str3.utf8)
        
        do {
            let decoder = JSONDecoder()
            let userCustom = try decoder.decode(UserCustomCodableStrategy.self, from: data)
            return "Hi, I'm \(userCustom.firstName) \(userCustom.lastName) and I'm \(userCustom.age) years old."
        } catch {
            return "Whoops: \(error.localizedDescription)"
        }
        
    }
    
}

#Preview {
    ContentView()
}
