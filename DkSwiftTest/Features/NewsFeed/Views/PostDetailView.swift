import SwiftUI

struct PostDetailView: View {
    let post: Post
    let viewModel: PostListViewModel
    @State private var comments: [Comment] = []
    @State private var user: User?
    @State private var isLoadingComments = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedImageView(urlString: post.thumbnailURL)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                if let user {
                    Label(user.name, systemImage: "person.circle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text(post.title)
                    .font(.title2.bold())

                Text(post.body)
                    .font(.body)
                    .foregroundStyle(.secondary)

                Divider()

                Text("댓글 (\(comments.count))")
                    .font(.headline)

                if isLoadingComments {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else if comments.isEmpty {
                    Text("댓글이 없습니다.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(comments) { comment in
                        CommentRow(comment: comment)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("게시글 상세")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            async let commentsTask = viewModel.fetchComments(for: post.id)
            async let userTask = viewModel.fetchUser(id: post.userId)
            comments = await commentsTask
            user = await userTask
            isLoadingComments = false
        }
    }
}

struct CommentRow: View {
    let comment: Comment

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(comment.name)
                .font(.subheadline.bold())
            Text(comment.email)
                .font(.caption)
                .foregroundStyle(.blue)
            Text(comment.body)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    }
}
