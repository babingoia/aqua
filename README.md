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

# Fluxos Importantes

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
