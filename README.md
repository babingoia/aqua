# aqua

# Bugs
-> FullScreen faz a camera sair dos limites

# Problemas de Lógica


# afazeres
-> Botar area2D nos tile pra botar som e modificações de velocidade

-> Atualizar o algoritmo do surf pra simular uma aceleração centrípeta

-> Fazer as hitboxes e hurtboxes
-> Fazer um ataque básico funcionar

-> Fazer as animações trocarem no walking (1 frame apenas)

# Convenções
-> Hability_Name e state_name são sempre iguais.

# Fluxos Importantes

## Arquitetura Geral de uma Cena
lesgo remodelar tudo de novo. O sistema vai funcionar da seguinte maneira:

-> Componente Puro: Será a parte mais isolada possível de um componente.
Não pode haver nenhuma dependência externa e sua exposição para fora é feita
à partir de signals que não esperam resposta, apenas expõem estado. Isso é feito
para que a parte "mecânica" fique isolada das regras de execução de cada cena.
Alguns componentes tem um ponto de entrada que executa funções que podem ser sobrescritas
como é o caso das habilidades. Nesse caso, é possível sobrescrever com chamada
"super.método()" para alterar o comportamento default e adicionar novas regras para
a execução em cada passo específico.

-> Adaptador de Componente: Será a parte concreta de um componente.
Ele vai gerenciar e modificar o componente puro por chamadas diretas ou herança
(preferível) com base no contexto daquela cena. Esse adaptador orquestra e/ou
sobrescreve alguns métodos do componente básico adicionando regras novas de execução
para aquela cena específica. É responsável também por criar novos signals que só
serão executados dentro daquele contexto específico para se comunicar com outras
partes do sistema. Isso é feito para manter algum nível de controle sobre a parte
concreta do sistema e ainda proporcionar margem para mudanças substantivas nos
componentes. 

-> EventsRelay: Classe concreta que vai armazenar todos os sinais dos componentes daquele objeto. 
Funciona literalmente como um relay para facilitar as conexões internas de uma cena
concreta pela interface do godot centralizando e gerenciando toda a sua comunicação.
Isso é importante porque esse hub de siganls vira a principal ferramenta para analisar
todo o fluxo da aplicação que é obrigado a passar por ele, além de facilitar as conexões.

-> StateMachine: Gerencia a troca de estados e é a fonte de verdade do sistema.
Sempre que a StateMachine transiciona de um estado para outro, ela emite um sinal
"state_changed(state_name: String)". Todo o sistema precisa ser gerenciado à partir
das reações a esses sinais que uma ou mais state_machines podem estar disparando
em uma cena, com cada uma delas sendo a fonte de verdade para o seu próprio domínio.

-> States: Gerenciam as transições de estado.
São os objetos concretos da fonte de verdade do sistema. Carregam nomes próprios
das bibliotecas e a lógica de transição entre si, emitindo sinais "finished()" 
para suas respectivas StateMachines que se conectam a esse sinal e trocam
de state quando disparado.

-> Managers: Resolvem conflitos entre domínios.
Se por um caso existir um ponto do sistema onde dois domínios precisam se comunicar
(como no caso do HabilitySurf), a recomendação é criar um manager que resolve esse
conflito criando e disparando os sinais necessários para transições específicas de
estados. (Ver: Habilidades e Seus Slots)

-> Bibliotecas com Nomes de Estados: Guardam os nomes de estados para evitar strings soltas.
Todos os nomes de states concretos devem ser registrados em uma biblioteca daquele
domínio específico. Essa biblioteca é quem vai dar nome aos estados os centralizando
em constantes num único arquivo para que toda a cena possa consultar. 

## Habilidades e seus Slots

-> IdleAction recebe Input -> FirstHability emite action_state_changed 
-> HabilityManager troca para active_hability correspondente
-> active_hability emite hability_changed 
-> IdleAction emite action_state_changed
-> HabilityManager troca active_hability para null_hability
-> Idle ou Walk trocam para Surf (por causa do hability_changed)
-> Surf emite movement_state_changed 
-> HabilityManager troca movement_hability para surf
-> Surf acaba -> Idle entra e emite movement_state_changed
-> HabilityManager troca movement_hability para null_hability
