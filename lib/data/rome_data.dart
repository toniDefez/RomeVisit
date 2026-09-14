import '../models/acto.dart';
import '../models/poi.dart';

/// Punto de partida y regreso de todas las rutas: el hotel.
const double hotelLat = 41.9023046;
const double hotelLon = 12.4737434;
const String hotelNombre = 'Hotel Magenta Deluxe Cancello';

/// Datos de los cuatro actos del viaje a Roma, separados de la interfaz
/// para poder editarlos con facilidad.
final List<Acto> actos = [
  Acto(
    id: 'augusto',
    diaSemana: 'Jueves',
    personaje: 'Augusto',
    biografia:
        'Cayo Julio Cesar Augusto, el primer emperador. Encontro una Roma '
        'de ladrillo y la dejo de marmol.',
    porQueEsSuDia:
        'Este dia es el de los cimientos: el foro, el palatino, el poder '
        'que se vuelve piedra. Cierra con Miguel Angel para enlazar con el '
        'dia siguiente.',
    pois: const [
      Poi(
        id: 'augusto-campo-de-fiori',
        nombre: "Campo de' Fiori",
        lat: 41.8956045,
        lon: 12.4721757,
        hora: '11:30',
        nota: 'Mercado y plaza viva; arranque tranquilo del viaje.',
      ),
      Poi(
        id: 'augusto-portico-ottavia',
        nombre: "Barrio Judio / Portico d'Ottavia",
        lat: 41.8925126,
        lon: 12.4785372,
        hora: '13:00',
        nota: 'Comer aqui: carciofi alla giudia (alcachofas a la judia).',
      ),
      Poi(
        id: 'augusto-coliseo',
        nombre: 'Coliseo',
        lat: 41.8902102,
        lon: 12.4922309,
        hora: '16:00',
        nota:
            'Entrada reservada a las 16:00 (Coliseo + Foro + Palatino). Se '
            'levanta sobre el lago del palacio de Neron.',
      ),
      Poi(
        id: 'augusto-foro-palatino',
        nombre: 'Foro y Palatino',
        lat: 41.8920906,
        lon: 12.4864378,
        hora: '17:00',
        nota:
            'El centro del mundo romano; la colina donde vivieron los '
            'emperadores.',
      ),
      Poi(
        id: 'augusto-san-pietro-in-vincoli',
        nombre: 'San Pietro in Vincoli (Moises de Miguel Angel)',
        lat: 41.8937984,
        lon: 12.4931498,
        hora: '18:30',
        nota:
            'OJO: cierra sobre las 18:50, llega con margen. La terribilita '
            'del Moises, la tragedia de la tumba de Julio II: puente hacia '
            'el Acto II.',
      ),
    ],
  ),
  Acto(
    id: 'julio-ii',
    diaSemana: 'Viernes',
    personaje: 'Julio II',
    biografia:
        'El papa Julio II, el "papa guerrero". El que encargo la Sixtina a '
        'Miguel Angel, las Estancias a Rafael, la nueva San Pedro, y fundo '
        'la Guardia Suiza en 1506.',
    porQueEsSuDia: 'Dia del Vaticano y del poder del Renacimiento.',
    pois: const [
      Poi(
        id: 'julioii-museos-vaticanos',
        nombre: 'Museos Vaticanos y Capilla Sixtina',
        lat: 41.9064878,
        lon: 12.4536413,
        hora: '8:30',
        nota: 'Entrada reservada 8:30. Hombros y rodillas cubiertos.',
      ),
      Poi(
        id: 'julioii-san-pedro',
        nombre: 'Basilica de San Pedro',
        lat: 41.9021667,
        lon: 12.4539367,
        hora: '11:30',
        nota:
            'La Piedad de un Miguel Angel joven; la cupula de un Miguel '
            'Angel viejo.',
      ),
      Poi(
        id: 'julioii-castel-sant-angelo',
        nombre: "Castel Sant'Angelo",
        lat: 41.9030632,
        lon: 12.466276,
        hora: '14:00',
        nota:
            'El mausoleo de Adriano convertido en fortaleza papal; el '
            'Passetto por el que huyo el papa en 1527. (Cierra los lunes.)',
      ),
      Poi(
        id: 'julioii-plaza-espana',
        nombre: 'Plaza de Espana',
        lat: 41.9056978,
        lon: 12.482327,
        hora: '16:50',
        nota:
            'Punto de encuentro del free tour a las 17:00: esquina con '
            'Vicolo del Bottino, junto al quiosco de flores. Llega a las '
            '16:50.',
      ),
      Poi(
        id: 'julioii-fontana-trevi',
        nombre: 'Fontana di Trevi',
        lat: 41.9009325,
        lon: 12.483313,
        hora: '17:30',
        nota: 'Dentro del free tour.',
      ),
      Poi(
        id: 'julioii-panteon',
        nombre: 'Panteon',
        lat: 41.8986108,
        lon: 12.4768729,
        hora: '18:30',
        nota: 'Dentro del free tour.',
      ),
      Poi(
        id: 'julioii-piazza-navona',
        nombre: 'Piazza Navona',
        lat: 41.8991633,
        lon: 12.4730742,
        hora: '19:30',
        nota: 'Fin del tour, a un paso del hotel.',
      ),
    ],
  ),
  Acto(
    id: 'bernini',
    diaSemana: 'Sabado',
    personaje: 'Bernini',
    biografia:
        'Gian Lorenzo Bernini, el hombre que dio forma al Barroco romano. '
        'Escultor, arquitecto, escenografo de la ciudad.',
    porQueEsSuDia:
        'Dia de moverse por Roma leyendo su mano por todas partes. Los '
        'saltos largos, mejor en metro (linea A).',
    pois: const [
      Poi(
        id: 'bernini-santa-maria-vittoria',
        nombre: 'Santa Maria della Vittoria (Extasis de Santa Teresa)',
        lat: 41.9046449,
        lon: 12.4942942,
        hora: '9:30',
        nota: 'Ve de manana: cierra de 12:00 a 16:00.',
      ),
      Poi(
        id: 'bernini-santa-maria-angeli',
        nombre: 'Santa Maria degli Angeli',
        lat: 41.9032171,
        lon: 12.4969794,
        hora: '10:00',
        nota: 'Iglesia dentro de las termas de Diocleciano.',
      ),
      Poi(
        id: 'bernini-san-juan-letran',
        nombre: 'San Juan de Letran y Scala Santa',
        lat: 41.8858811,
        lon: 12.505673,
        hora: '11:00',
        nota: 'La catedral de Roma.',
      ),
      Poi(
        id: 'bernini-termas-caracalla',
        nombre: 'Termas de Caracalla',
        lat: 41.8790382,
        lon: 12.4924394,
        hora: '12:30',
        nota:
            'Callback al edicto del 212 (ciudadania para todos). Sabado '
            '9-18; cierra lunes.',
      ),
      Poi(
        id: 'bernini-circo-massimo',
        nombre: 'Circo Massimo',
        lat: 41.8858762,
        lon: 12.4857578,
        hora: '13:45',
        nota: 'El estadio de las carreras de carros de toda la vida.',
      ),
      Poi(
        id: 'bernini-ojo-cerradura-aventino',
        nombre: 'Ojo de la cerradura del Aventino',
        lat: 41.8829829,
        lon: 12.4784752,
        hora: '14:15',
        nota:
            'Mira por la cerradura: la cupula de San Pedro alineada al '
            'fondo.',
      ),
      Poi(
        id: 'bernini-teatro-marcello',
        nombre: 'Teatro di Marcello',
        lat: 41.8919308,
        lon: 12.4799083,
        hora: '15:15',
        nota: 'El hermano pequeno del Coliseo, y mas antiguo.',
      ),
      Poi(
        id: 'bernini-altar-patria',
        nombre: 'Altar de la Patria (Vittoriano)',
        lat: 41.894891,
        lon: 12.4829541,
        hora: '15:45',
        nota: 'La "maquina de escribir" que domina la plaza Venecia.',
      ),
      Poi(
        id: 'bernini-foros-imperiales',
        nombre: 'Foros Imperiales y Columna de Trajano',
        lat: 41.8948798,
        lon: 12.48529,
        hora: '16:15',
        nota: 'El relato de la conquista de Dacia, tallado en espiral.',
      ),
    ],
  ),
  Acto(
    id: 'adriano',
    diaSemana: 'Domingo',
    personaje: 'Adriano',
    biografia:
        'El emperador Adriano, el viajero, el arquitecto, el que '
        'reconstruyo el Panteon.',
    porQueEsSuDia:
        'Manana corta antes del vuelo: dos joyas con calma y a por la '
        'maleta.',
    pois: const [
      Poi(
        id: 'adriano-fontana-trevi',
        nombre: 'Fontana di Trevi',
        lat: 41.9009325,
        lon: 12.483313,
        hora: '7:45',
        nota: 'Temprano, sin gente.',
      ),
      Poi(
        id: 'adriano-panteon',
        nombre: 'Panteon',
        lat: 41.8986108,
        lon: 12.4768729,
        hora: '8:15',
        nota:
            'OJO: abre a las 9:00. Primero Trevi con calma y entra al '
            'Panteon al abrir. El oculo, la obra de Adriano. Despues: '
            'vuelta al hotel, desayuno y check-out (hasta las 10:00). '
            'Taxi sobre las 10:45 a Fiumicino (tarifa fija 50 EUR), vuelo '
            '13:45.',
      ),
    ],
  ),
];
