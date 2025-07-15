# 📱 Asset Tree Viewer – TRACTIAN Challenge (Flutter)

Este é o desafio técnico para a vaga de **Mobile Software Engineer** da TRACTIAN.

O projeto consiste em um aplicativo Flutter que consome dados da API pública da TRACTIAN e renderiza uma árvore hierárquica contendo **localizações**, **ativos** e **componentes com sensores**, respeitando os requisitos visuais e funcionais da proposta.

---

## ✨ Funcionalidades

- ✅ Seleção de empresas com dados distintos
- ✅ Árvore hierárquica com:
    - Localizações (e sub-localizações)
    - Ativos e sub-ativos
    - Componentes com sensores (energia ou vibração)
- ✅ Ícones personalizados por tipo de nó
- ✅ Filtros:
    - Busca por nome (texto)
    - Mostrar apenas sensores de energia ⚡
    - Mostrar apenas status crítico 🔴
- ✅ Caminho completo visível mesmo com filtros ativos
- ✅ Otimizado para lidar com grande volume de dados (ex: Apex)

---

## 🧰 Tecnologias utilizadas

- Flutter 3.x
- Provider (gerenciamento de estado)
- Isolates com `compute()` (para performance)
- Consumo de API via `http`
- Estrutura modular e enxuta para fácil manutenção

---

## ▶️ Demonstração (vídeo)

📽️ O vídeo demonstra:

1. Abertura do app e seleção de empresa
2. Renderização da árvore de ativos
3. Aplicação dos filtros
4. Expansão de ramos da árvore

  DENTRO DO REPOSITORIO NA BRANCH master COM O NOME `Screen_Recording_20250715_093651.mp4`
> 🔗 **[https://github.com/rpassareli/challengesTRACTIAN/blob/master/Screen_Recording_20250715_093651.mp4]**
> ou NO GOOGLE DRIVE
> > 🔗**[https://drive.google.com/file/d/1-tLJ1dQEt79W3ON0C8Tnrt32sRAAG5Kj/view?usp=drive_link]**

---


## 🧠 Melhorias que aplicaria com mais tempo

- **Virtualização total da árvore**: usar `flutter_lazy_tree` ou `SliverList` para renderizar apenas o que está visível no scroll.
- **Collapse / Expand All**: botões para expandir ou colapsar toda a árvore com um clique.
- **Animações suaves**: entre abertura e fechamento dos nós com `AnimatedSize` e `AnimatedSwitcher`.
- **Scroll automático até item buscado**: ao usar a busca, posicionar automaticamente o item filtrado na viewport.
- **Arquitetura escalável com modularização por feature (ex: `riverpod + modular`)**.
- **Testes automatizados (widget e unitários)** para garantir consistência das interações e da filtragem.
- **🌙 Suporte a Dark Mode**: adaptação visual do app com base no tema do sistema ou comutador manual.
- **🌍 Suporte a múltiplos idiomas (i18n)**: estruturação com `flutter_localizations` para tornar o app acessível em diferentes países (ex: PT-BR, EN, ES).

---

## 🚀 Como rodar o projeto localmente

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/challenge-tractian-flutter.git
cd challenge-tractian-flutter

# Instale as dependências
flutter pub get

# Execute o app
flutter run

📁 Organização do projeto
lib/
├── models/           # Models com sufixo _model.dart
├── provider/         # Provider principal da árvore
├── service/          # Consumo da API
├── utils/            # Build da árvore com compute()
├── pages/            # Páginas Home e AssetTree
└── widgets/          # Filtros e widgets recursivos

🤝 Agradecimento
Agradeço a oportunidade de participar do desafio e mostrar minhas habilidades com Flutter, estruturação limpa, foco em performance e UX.

Fico à disposição para qualquer dúvida. 🚀

