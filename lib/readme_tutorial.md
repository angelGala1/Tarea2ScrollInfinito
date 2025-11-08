📱 Aplicación de Artículos con Scroll Infinito
Una aplicación Flutter moderna que implementa scroll infinito, paginación y arquitectura limpia para mostrar artículos de forma eficiente y escalable.

✨ Características Principales

🔄 Scroll Infinito: Carga automática de artículos al hacer scroll
📄 Paginación Manual: Navegación directa entre páginas con widget personalizado
🎨 Diseño Responsivo: Adaptado para móvil, tablet y desktop
♻️ Pull to Refresh: Actualización de contenido con gesto de arrastre
🏗️ Clean Architecture: Separación clara de responsabilidades
🧪 Testing: Tests unitarios y de widgets incluidos
🚀 BLoC Pattern: Gestión de estado reactiva y predecible
🎯 Banner Destacado: Banner principal con artículo featured

🏛️ Arquitectura
El proyecto sigue los principios de Clean Architecture con separación en 3 capa
lib/
├── core/
│   ├── network/          # Configuración de red (Dio, interceptores)
│   ├── errors/           # Manejo de errores y excepciones
│   └── utils/            # Utilidades y constantes (dimensiones, colores)
├── features/
│   └── article/
│       ├── data/
│       │   ├── datasources/    # RemoteDataSource (API calls)
│       │   ├── models/         # Modelos de datos (JSON parsing)
│       │   └── repositories/   # Implementación de repositorios
│       ├── domain/
│       │   ├── entities/       # Entidades del dominio
│       │   ├── repositories/   # Contratos de repositorios (interfaces)
│       │   └── usecases/       # Casos de uso del negocio
│       └── presentation/
│           ├── bloc/           # Lógica de estado (BLoC + Events + States)
│           ├── pages/          # Páginas principales (HomePage)
│           └── widgets/        # Componentes reutilizables
└── test/
├── bloc/             # Tests del BLoC
└── widget/           # Tests de widgets


BLoC Pattern

// Eventos
- LoadArticlesEvent: Carga inicial (página 1)
- LoadMoreArticlesEvent: Carga siguiente página (scroll infinito)
- RefreshArticlesEvent: Refresca desde página 1
- LoadPageEvent: Carga una página específica



Manejo de Errores
Sistema robusto de manejo de errores con NetworkFailure:

Timeout
Sin conexión a internet
Errores del servidor (400, 401, 404, 500, etc.)
Solicitudes canceladas


DEPLOY
Escoger el emulador android o IOS, web o escritorio
Para ejecutar en web , usarlo con este comando flutter run -d chrome --web-browser-flag "--disable-web-security"
por el tema de cors


📄 Licencia
Este proyecto está bajo la Licencia MIT. Ver el archivo LICENSE para más detalles.
👨‍💻 Autor
Angel Gala

GitHub: @angelGala1
Proyecto: Tarea2ScrollInfinito

GIT HUB
https://github.com/angelGala1/Tarea2ScrollInfinito

🙏 Agradecimientos

Flutter Team por el excelente framework
Comunidad de flutter_bloc por los paquetes
Todos los contribuidores del proyecto


APK
https://www.mediafire.com/file/06zcyayimjqrj3m/app-release.apk/file