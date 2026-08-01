# aqua
 
# afazeres
-> Botar area2D nos tile pra botar som
-> Atualizar o algoritmo do surf pra simular uma aceleração centrípeta
-> Fazer as hitboxes e hurtboxes
-> Fazer um ataque básico funcionar
-> Fazer as animações trocarem no walking (1 frame apenas)

# Fluxos Importantes

## Transições de Estados (StateMachine)

### Responsabilidades
StateMachine: Executa a lógica de transição entre States.
State: Executa a lógica daquele state e envia o próximo.
PlayerState: Guarda os caminhos dos outros States e Animações.
Hability: Executa a lógica de uma habilidade.
Response: Resposta da execução do hability

### Inicio
PlayerState -> Carrega todos os caminhos e nomes de Animações 
StateMachine -> Recolhe todos os states 

### Ciclo
StateMachine Inicia o state padrão -> Executa Hability checa Response ->
Pega o próximo State de PlayerState ->Emite Finished com próximo State ->
Ciclo Recomeça
