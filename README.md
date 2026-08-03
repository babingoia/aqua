# aqua

# Bugs
-> FullScreen faz a camera sair dos limites


# Problemas de Lógica
-> Porque um state carrega um character e uma hability ao mesmo tempo?
-> Porque uma hability carrega o nome de um state e de uma anim?


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


##

StateIdle -> Botão -> StateWalking -> Dispara state_changed
-> HabilityWalk capta o signal -> Ativa o execute que roda em loop
-> Próximo state_changed desativa o loop do execute

### Inscrições de HabilityWalking

velocity_changed: mantém uma cópia da velocity para aplicar
rapidamente ao move_and_slide que muda via signal.

state_changed: ativa e desativa o loop do execute que aplica
velocity ao target.

### Exports

Target: Aquele ao qual o movimento será aplicado.
