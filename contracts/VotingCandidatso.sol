// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;
contract VotingCandidatso{
    address President;
    uint256 public rondaActual;
    constructor () {
      President = msg.sender;
      rondaActual = 1;
    }
    struct Candidato {
        address id;
        bool activo;
    }
    //      RondasActual =>    canidato => Candidato
    mapping(uint256 => mapping(address => Candidato)) public candidatosPorRonda;
    //      RondasActual =>    votante => votos
    mapping(uint256 => mapping(address => uint256)) public votesRondaC;
    //      RondasActual => lista de candidatos
    mapping(uint256 => address[]) public listaCandidatosPorRonda;
    //       RondasActual =>    votos del ganador
    mapping(uint256 => uint256) public votosGanadorPorRonda;
    // ganador por ronda 
    //      RondasActual =>    ganador => votosGanador
    mapping(uint256 => address) public ganadorPorRonda;
    //      RondasActual =>    canidato => votos
    mapping(uint256 => mapping(address => uint256)) public votosPorCandidato;
    //     RondasActual =>    votante => si voto      
    mapping(uint256 => mapping (address => bool)) public yaVotoXRonda;
    
    modifier OnlyPresident()  {
    require(msg.sender == President, "only president can access to function " );
    _;
    }
    //Eventos
    event Voto(address voter, address Candidato, uint256 have);
    event candidato_agregado(address nombre);
    event Ganador_Obtenido(address ganador, uint256 votosGanador);
    event Ronda_Reniciar(uint256 rondaActual);

    function obtenerPresidente() public view returns (address) {
        return President;
    }
    function agregarCandidato(address _id) public OnlyPresident{
      require(!candidatosPorRonda[rondaActual][_id].activo, "The candidate has already been added");
      candidatosPorRonda[rondaActual][_id] = Candidato({
        id: _id,
        activo: true
      });
      listaCandidatosPorRonda[rondaActual].push(_id);
      emit candidato_agregado(_id);
    }
    function votarCandidato(address _id) public {
      require(candidatosPorRonda[rondaActual][_id].activo, "has to be a valid candidate");
      require(!yaVotoXRonda[rondaActual][msg.sender],"I already vote");
        votosPorCandidato[rondaActual][_id] += 1;
        yaVotoXRonda[rondaActual][msg.sender] = true;
        if(votosPorCandidato[rondaActual][_id] > votosGanadorPorRonda[rondaActual]){
            // Update the winner for the current round
            votosGanadorPorRonda[rondaActual] = votosPorCandidato[rondaActual][_id];
            // Update the winner address for the current round
            ganadorPorRonda[rondaActual] = _id;
            // Emit the event for the new winner
            emit Ganador_Obtenido(_id, votosGanadorPorRonda[rondaActual]);
        }
    }
    function obtenerCandidatosActuales() public view returns (address[] memory) {
    return listaCandidatosPorRonda[rondaActual];
}
    function obtenerGanadorRonda(uint256 _index) public view returns (address, uint256) {
      //in function vue this not permitted emit events
       address ganador = ganadorPorRonda[_index];
      require(ganador != address(0), "There are no votes yet");
     return (ganador, votosPorCandidato[_index][ganador]);
    }
    function finalizarVotacionActual() public OnlyPresident {
    address ganador = ganadorPorRonda[rondaActual];
    require(ganador != address(0), "No se puede finalizar, aun no hay votos");
    emit Ganador_Obtenido(ganador, votosGanadorPorRonda[rondaActual]);
}
   function iniciarNuevaRonda() public OnlyPresident {
    rondaActual += 1;
    votosGanadorPorRonda[rondaActual] = 0;
    emit Ronda_Reniciar(rondaActual);
}

    
}
