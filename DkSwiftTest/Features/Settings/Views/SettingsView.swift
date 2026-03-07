import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section("프로필") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(viewModel.selectedColor)
                        VStack(alignment: .leading) {
                            Text(viewModel.profile.name)
                                .font(.headline)
                            Text(viewModel.profile.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Button("프로필 편집") {
                        viewModel.showingProfileSheet = true
                    }
                }

                Section("화면") {
                    Toggle("다크 모드", isOn: $viewModel.isDarkMode)
                    VStack(alignment: .leading) {
                        Text("글자 크기: \(Int(viewModel.fontSize))pt")
                        Slider(value: $viewModel.fontSize, in: 12...24, step: 1)
                    }
                }

                Section("테마 색상") {
                    Picker("테마", selection: $viewModel.themeColorName) {
                        ForEach(SettingsViewModel.availableColors, id: \.name) { item in
                            Label(item.name.capitalized, systemImage: "circle.fill")
                                .foregroundStyle(item.color)
                                .tag(item.name)
                        }
                    }
                }

                Section {
                    Button("모든 설정 초기화", role: .destructive) {
                        viewModel.showingResetAlert = true
                    }
                }

                Section("앱 정보") {
                    LabeledContent("버전", value: "1.0.0")
                    LabeledContent("빌드", value: "1")
                }
            }
            .navigationTitle("설정")
            .sheet(isPresented: $viewModel.showingProfileSheet) {
                ProfileEditSheet(viewModel: viewModel)
            }
            .alert("설정 초기화", isPresented: $viewModel.showingResetAlert) {
                Button("초기화", role: .destructive) { viewModel.resetAll() }
                Button("취소", role: .cancel) {}
            } message: {
                Text("모든 설정을 기본값으로 되돌리시겠습니까?")
            }
        }
    }
}

struct ProfileEditSheet: View {
    @Bindable var viewModel: SettingsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("이름", text: $name)
                TextField("이메일", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            .navigationTitle("프로필 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        viewModel.profile = UserProfile(name: name, email: email)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                name = viewModel.profile.name
                email = viewModel.profile.email
            }
        }
    }
}
