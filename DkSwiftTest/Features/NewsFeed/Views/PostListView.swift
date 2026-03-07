import SwiftUI

struct PostListView: View {
    @State private var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("로딩 중...")
                } else if let error = viewModel.error, viewModel.posts.isEmpty {
                    ErrorStateView(error: error) {
                        Task { await viewModel.fetchPosts() }
                    }
                } else {
                    List(viewModel.filteredPosts) { post in
                        NavigationLink(value: post.id) {
                            PostRow(post: post)
                        }
                    }
                    .navigationDestination(for: Int.self) { postId in
                        if let post = viewModel.posts.first(where: { $0.id == postId }) {
                            PostDetailView(post: post, viewModel: viewModel)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchPosts()
                    }
                }
            }
            .navigationTitle("뉴스피드")
            .searchable(text: $viewModel.searchText, prompt: "게시글 검색")
        }
        .task {
            if viewModel.posts.isEmpty {
                await viewModel.fetchPosts()
            }
        }
    }
}

struct PostRow: View {
    let post: Post

    var body: some View {
        HStack(spacing: 12) {
            CachedImageView(urlString: post.thumbnailURL)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(post.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(post.body)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}
