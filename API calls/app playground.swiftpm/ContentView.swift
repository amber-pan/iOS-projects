import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack (spacing:20){
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
            placeholder: {
                Circle()
                    .foregroundColor(.pink)
            }
                .frame(width: 120, height: 120)
            Text(user?.login ?? "Login Placeholder")
                .font(.title2)
            Text(user?.bio ?? "Bio Placeholder")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
                
            } catch  GHError.invalidURL{
                print("invalid URL")
            }
            catch GHError.invalidResponse{
                print("invalid Response")
            }
            catch GHError.invalidData{
                print("invalid Data")
            }
            catch {
                print("Unexpected error")
            }

        }
    }
    
    func getUser() async throws ->GitHubUser{
        
 //check  rate limit
        let rateLimitURL = URL(string: "https://api.github.com/rate_limit")!
        let (dataR, responseR) = try await URLSession.shared.data(from: rateLimitURL)

        print(String(data: dataR, encoding: .utf8)!)
 
//get data from API
        let endpoint = "https://api.github.com/users/amber-pan"
        //sallen0400"
       
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
            }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
 //print data
        print("Data Length: \(data.count)")
        print("Raw Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
        
//print response
//        print (response)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
      
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        }
        catch{
            print ("did not get decode data, Decoding Error: \(error.localizedDescription)") //  Pactual error")
            throw GHError.invalidData }

    }
}

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String //in case it is null decoding will not work if don't use ?

}

enum GHError:Error{
        case invalidURL
    case invalidResponse
    case invalidData
}
