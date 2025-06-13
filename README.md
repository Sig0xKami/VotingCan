# 🗳️ Smart Contract: VotingCandidatos

Contrato inteligente en Solidity para gestionar un sistema de votación descentralizado con múltiples rondas, control de acceso y detección automática de ganadores. Diseñado para integrarse fácilmente con dApps en Ethereum.

---

## 📜 Descripción

Este contrato permite:

- Crear múltiples rondas de votación.
- Agregar candidatos por ronda (solo el presidente).
- Votar por un candidato en la ronda actual.
- Detectar automáticamente al candidato con más votos.
- Consultar resultados históricos por ronda.
- Iniciar nuevas rondas controladas por una única cuenta "presidente".

Ideal para aplicaciones descentralizadas educativas, DAOs simples, votaciones institucionales o elecciones internas.

---

## 🛠️ Tecnologías

- Solidity `^0.8.26`
- Deploy sugerido con Hardhat

---

## ⚙️ Funcionalidades Principales

| Función                            | Descripción                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|
| `agregarCandidato(address)`       | Agrega un candidato a la ronda actual (solo presidente).                   |
| `votarCandidato(address)`         | Permite votar por un candidato activo. Solo 1 voto por dirección por ronda.|
| `obtenerGanadorRonda(uint256)`   | Devuelve el candidato ganador y la cantidad de votos de una ronda dada.    |
| `iniciarNuevaRonda()`             | Incrementa el número de ronda y reinicia el estado de votación.            |
| `finalizarVotacionActual()`       | Lanza evento del ganador actual (si lo hay).                               |
| `obtenerCandidatosActuales()`     | Devuelve lista de candidatos activos en la ronda actual.                   |

---

## 🔐 Roles

- **Presidente**: dirección del deployer; puede agregar candidatos e iniciar rondas.
- **Votantes**: cualquier dirección externa puede votar una sola vez por ronda.

---

## 📦 Eventos

- `Voto(address voter, address candidato, uint256 totalVotos)`
- `candidato_agregado(address candidato)`
- `Ganador_Obtenido(address ganador, uint256 votos)`
- `Ronda_Reniciar(uint256 nuevaRonda)`

---

## 📂 Estructuras Importantes

```solidity
struct Candidato {
    address id;
    bool activo;
}
