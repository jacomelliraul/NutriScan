import SwiftUI

struct CalorieData {
    static var goal: Int = 2000
    static var consumed: Int = 1247
}

struct HomeView: View {
    let streakDays = 7
    let weeklyAverage = 87
    let macros = (protein: (89, 120), carbs: (156, 250), fats: (45, 70))
    
    @State private var botao = false
    @State private var goal: Int = CalorieData.goal // inicializa com o valor global
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Olá, Gabriel")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()

                Text("Como está sua alimentação hoje?")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 24) {
                    HStack(spacing: 16) {
                        indicator(title: "NutriScan", subtitle: "Alimentando o futuro da sua saúde")

                    }

                    NavigationLink(destination: ChangeCaloriaView()) {
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                                .frame(width: 150, height: 150)

                            Circle()
                                .trim(from: 0, to: CGFloat(CalorieData.consumed) / CGFloat(goal))
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .frame(width: 150, height: 150)

                            VStack {
                                Text("\(CalorieData.consumed)")
                                    .font(.system(size: 36, weight: .bold))
                                Text("de \(goal) kcal")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("\(goal - CalorieData.consumed) restantes")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Macronutrientes")
                            .font(.headline)
                        macroRow(name: "Proteínas", values: macros.protein, color: .blue)
                        macroRow(name: "Carboidratos", values: macros.carbs, color: .orange)
                        macroRow(name: "Gorduras", values: macros.fats, color: .pink)
                    }
                }

                Button(action: {
                    botao = true
                }) {
                    Text("DETALHES")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
                .sheet(isPresented: $botao) {
                    AdicionarInfo(date: .constant(Date()))
                }
            }
            .onAppear {
                // recarrega valor atualizado da variável global
                goal = CalorieData.goal
            }
            .padding()
        }
    }

    @ViewBuilder
    func indicator(title: String, subtitle: String) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundStyle(.green)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    @ViewBuilder
    func macroRow(name: String, values: (current: Int, goal: Int), color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                Spacer()
                Text("\(values.current) / \(values.goal)g")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            ProgressView(value: Double(values.current), total: Double(values.goal))
                .accentColor(color)
        }
    }
}
#Preview {
    HomeView()
}
