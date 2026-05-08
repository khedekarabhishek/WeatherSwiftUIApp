//
//  TaskGroupImagesView.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 06/05/26.
//

import SwiftUI

class TaskGroupImagesViewDataManager {
    func getImagesFromTaskGroup(urlStrings: [String]) async throws -> [UIImage] {
        var images: [UIImage] = []

        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            for urlString in urlStrings {
                group.addTask { [weak self] in
                    try? await self?.fetchImage(urlString: urlString) ?? UIImage()
                }
            }
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            return images
        }
    }

    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badURL)
        }
        return image
    }
}

class TaskGroupImagesViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    private let urlStrings: [String] = [
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
        "https://picsum.photos/300",
    ]
    private var manager: TaskGroupImagesViewDataManager
    
    init(manager: TaskGroupImagesViewDataManager) {
        self.manager = manager
    }
    
    func getImages() async {
        do {
            let images = try await manager.getImagesFromTaskGroup(urlStrings: urlStrings)
            DispatchQueue.main.async {
                self.images = images
            }
        } catch {
            print(error)
        }
    }
}

struct TaskGroupImagesView: View {
    @StateObject private var viewModel: TaskGroupImagesViewModel = TaskGroupImagesViewModel(manager: TaskGroupImagesViewDataManager())

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                          content: {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Task Group")
            .task {
                await viewModel.getImages()
            }
        }
    }
}

struct TaskGroupImagesView_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupImagesView()
    }
}
