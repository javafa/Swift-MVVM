# Swift MVVM
MVVM with swiftui and combine
View -> ViewModel -> Repository -> Datasource

## View
### GithubUserView
```
struct GithubUserView: View {
    
    @ObservedObject var viewModel = GithubUserViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users, id:\.id) {
                GithubUserItemView(user: $0)
            }
            .navigationTitle("Github User Api")
            .onAppear {
                self.viewModel.fetchUsers()
            }
        }
    }
}
```
### GithubUserItemView
```
struct GithubUserItemView: View {
    
    private let user:GithubUser
    
    init(user:GithubUser) {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.login)
                .font(Spoqa.h5_18_bold)
                .foregroundColor(Color("GRAY800"))
            Text(user.avatar_url)
                .font(Spoqa.body2_14)
                .foregroundColor(Color("GRAY600"))
        }
    }
}
```
## ViewModel
### BaseViewModel
```
class BaseViewModel : ObservableObject {
    var cancelables : Set<AnyCancellable> = []
}
```
### GithubUserViewModel
```
class GithubUserViewModel : BaseViewModel {
    private var repository = GithubRepository()
    
    @Published var users: [GithubUser] = []
    
    func fetchUsers() {
        repository.getUsers()
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &cancelables)
    }
}
```
## Repository
try local DAO strategy by yourself
### GithubRepository
```
class GithubRepository {

    private var remote = GithubDatasource()
    private var local = GithubUserDAO()
    
    func getUsers() -> AnyPublisher<[GithubUser], Never> {
        debugPrint("GithubRepository", "getUsers()")
        return remote.getUsers()
            .map { $0.data }
            .decode(type: [GithubUser].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
```
## DataSource
### BaseDatasource
```
class BaseDatasource : ObservableObject {
    static let BASE = "https://api.github.com"
    
    func subscribe(uri:String) -> URLSession.DataTaskPublisher {
        let full_url = "\(BaseDatasource.BASE)/\(uri)"
        return URLSession.shared.dataTaskPublisher(for: URL(string: full_url)!)
    }
}
```
### GithubDatasource
```
class GithubDatasource : BaseDatasource {
    func getUsers() -> URLSession.DataTaskPublisher {
        debugPrint("GithubDatasource", "getUsers()")
        return subscribe(uri: "users")
    }
}
```